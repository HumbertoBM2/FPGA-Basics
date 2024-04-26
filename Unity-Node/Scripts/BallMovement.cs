using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class BallMovement : MonoBehaviour
{

    public float moveSpeed ;
    public float jumpForce ;
    public Rigidbody2D rig;



    // Update is called once per frame
    void Update()
    {
        if(PlayerPrefs.GetString("up")=="1")
        {
            Debug.Log("UP!");
            rig.AddForce(Vector2.up * jumpForce, ForceMode2D.Impulse);
        }
        
    }

    public void FixedUpdat()
    {
        if (PlayerPrefs.GetString("right")=="1")
        {
            rig.velocity = new Vector2(moveSpeed, rig.velocity.y);
        }
        if (PlayerPrefs.GetString("left")=="1")
        {
            rig.velocity = new Vector2(-moveSpeed, rig.velocity.y);
        }
    }
    
}
