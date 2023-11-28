using System.Collections;
using System.Collections.Generic;
using UnityEngine;

[RequireComponent (typeof (MeshFilter))]
[RequireComponent (typeof (MeshRenderer))]
public class BackgroundSetup : MonoBehaviour
{
	private void Awake()
	{
		BackgroundMesh background = new BackgroundMesh();

		GetComponent<MeshFilter>().mesh = background.MeshBackground;
	}
}
