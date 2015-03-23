using UnityEngine;
using System.Collections;

public class StandingBoxCoverNode : CoverNode
{


    void Start() 
    {
        
    }

    public override void Update()
    {
		if (PersonInCover)
		{
			Debug.Log("hio");
		}
    }

    public override bool EnterCoverr(GameObject person)
    {
		if (person)
		{
			PersonInCover = person;
			return true;
		}
		else
		{
			Debug.Log("No one in cover");
			return false;
		}
    }
}