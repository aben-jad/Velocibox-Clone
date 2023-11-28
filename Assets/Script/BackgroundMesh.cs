using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class BackgroundMesh
{
	private Mesh meshBackground;
	private Vector3 localLength;

	public Mesh MeshBackground
	{
		get => meshBackground;
	}

	public BackgroundMesh()
	{
		meshBackground = new Mesh();

		localLength = new Vector3(.5f, .5f, .5f);

		meshBackground.SetVertices(GetVertices());

		meshBackground.SetTriangles(GetTriangles(), 0);

		meshBackground.SetUVs(0, GetUvs());

		meshBackground.RecalculateNormals();
	}

	private Vector3[] GetVertices()
	{
		List<Vector3> vertices = new();

		vertices.Add(new Vector3(-localLength.x, -localLength.y, -localLength.z));
		vertices.Add(new Vector3(localLength.x, -localLength.y, -localLength.z));
		vertices.Add(new Vector3(-localLength.x, -localLength.y, localLength.z));
		vertices.Add(new Vector3(localLength.x, -localLength.y, localLength.z));

		vertices.Add(new Vector3(localLength.x, -localLength.y, -localLength.z));
		vertices.Add(new Vector3(localLength.x, localLength.y, -localLength.z));
		vertices.Add(new Vector3(localLength.x, -localLength.y, localLength.z));
		vertices.Add(new Vector3(localLength.x, localLength.y, localLength.z));

		vertices.Add(new Vector3(localLength.x, localLength.y, -localLength.z));
		vertices.Add(new Vector3(-localLength.x, localLength.y, -localLength.z));
		vertices.Add(new Vector3(localLength.x, localLength.y, localLength.z));
		vertices.Add(new Vector3(-localLength.x, localLength.y, localLength.z));

		vertices.Add(new Vector3(-localLength.x, localLength.y, -localLength.z));
		vertices.Add(new Vector3(-localLength.x, -localLength.y, -localLength.z));
		vertices.Add(new Vector3(-localLength.x, localLength.y, localLength.z));
		vertices.Add(new Vector3(-localLength.x, -localLength.y, localLength.z));

		return (vertices.ToArray());
	}

	private int[] GetTriangles()
	{
		List<int> tri = new();

		int len = meshBackground.vertexCount;

		for (int i = 0; i < len; i+= 4)
		{
			tri.Add(0 + i);
			tri.Add(1 + i);
			tri.Add(2 + i);

			tri.Add(1 + i);
			tri.Add(3 + i);
			tri.Add(2 + i);
		}

		return tri.ToArray();
	}

	private Vector2[] GetUvs()
	{
		List<Vector2> uvs = new();

		int len = meshBackground.vertexCount;

		for (int i = 0; i < len; i+= 4)
		{
			uvs.Add(new Vector2(0, 0));
			uvs.Add(new Vector2(1, 0));
			uvs.Add(new Vector2(0, 1));
			uvs.Add(new Vector2(1, 1));
		}

		return uvs.ToArray();
	}
}
