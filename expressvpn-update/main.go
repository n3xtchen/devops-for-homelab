
package main

import (
    "strings"
    "fmt"
    "net/http"
    "os"
    "io"
    "io/ioutil"

    "github.com/antchfx/htmlquery"
)

func main() {
    requestURL := "https://www.expressvpn.com/latest#linux"
    res, err := http.Get(requestURL)
    if err != nil {
        fmt.Printf("error making http request: %s\n", err)
        os.Exit(1)
    }

    fmt.Printf("Status code: %d\n", res.StatusCode)

    resBody, err := ioutil.ReadAll(res.Body)
    doc, err := htmlquery.Parse(strings.NewReader(string(resBody)))
    option := htmlquery.FindOne(doc, "//option[contains(., 'Raspberry Pi OS')]")
    downloadUrl := htmlquery.SelectAttr(option, "value")

    fmt.Printf("download url: %s\n", downloadUrl)

    tmp := strings.Split(downloadUrl, "/")
    fileName := tmp[len(tmp)-1]
    fmt.Printf("File Name: %s\n", fileName)

    DownloadFile(downloadUrl, fileName)
}

func DownloadFile(url string, filepath string) error {
    // Create the file
	out, err := os.Create(filepath)
	if err != nil {
		return err
	}
	defer out.Close()

	// Get the data
	resp, err := http.Get(url)
	if err != nil {
		return err
	}
	defer resp.Body.Close()

	// Write the body to file
	_, err = io.Copy(out, resp.Body)
	if err != nil {
		return err
	}

	return nil
}
