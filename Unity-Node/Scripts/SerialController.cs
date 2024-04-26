using System.Collections;
using System.Collections.Generic;
using UnityEngine;
using System.IO.Ports;
public class SerialController : MonoBehaviour
{

    public string recievedData;
    public string[] data;

    SerialPort NodeMCU = new SerialPort("COM6", 9600);
    // Start is called before the first frame update
    void Start()
    {
        NodeMCU.Open();
        
        
    }

    // Update is called once per frame
    void Update()
    {
        recievedData = NodeMCU.ReadLine();
        Debug.Log(recievedData);
        string[] data = recievedData.Split(',');
        PlayerPrefs.SetString("left", data[0]);
        PlayerPrefs.SetString("up", data[1]);
        PlayerPrefs.SetString("right", data[2]);


    }
}
