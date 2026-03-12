Received: from SN4PR0501CU005.outbound.protection.outlook.com (mail-southcentralusazon11011064.outbound.protection.outlook.com [40.93.194.64])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 45065381B13;
	Thu, 12 Mar 2026 06:35:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.194.64
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773297309; cv=fail; b=pw8qVC/gkJndTEj46zmsRqWPh3PsU4VrAGJTHxbpr9tmmw6hbtPcD06gpqtsJGi8l/YzaI4kujZbiqpPXIfbYyIML6nW/kPGzlttrXLwmCh2BDhSeaaPY0fvZHTRjQD/g4FB38GpIactWobV2RC26d2f0BS4dbWnHTPVvJ72w8s=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773297309; c=relaxed/simple;
	bh=rjaTqyhEaKDuyTXt89q0O2FtdXsJd1OXhticyrVz5Rs=;
	h=Content-Type:Date:Message-Id:Cc:Subject:From:To:References:
	 In-Reply-To:MIME-Version; b=GF8QfOkwl+ZwEdBeX3GWup4f+J1EbQYjj7Rm51VfyDBIGDU+CB4BuyixmtO/ll4pKYQYsJR0Jta07J3vVeSebaz1HSsZJOzZbfJf8EDOhETYZJxvk2VjkNZGSBg/rukI9Z/l7XtMVX80G/OWfZ/EX40NppPFuJF+F8ZfKYhWjGI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=FTC4BTEz; arc=fail smtp.client-ip=40.93.194.64
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="FTC4BTEz"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Pep8gXUor0zBlMZ3YXJN5gxt79IzshNlmVlMm4AjdrNMclZ+o6gYz07CwCFvKu/tBZav5XDwkAByE6WfgOFjKN8ms9uXJ6/Gtgz3Fiwt9T++a8lRW9uQ2x+98FzQePWCg/XvPumbHtHFkdKwjenmEKrubdJ5dkN0/AWOL4rn65D1PJCe03Vud+LsUWTbnfXTSs4W+C/+kIea4lLn57h5hMu1Y6oiEPTLqhktAJeaCbYla7EOXUY3+j1ohvAsjseMYM6L8iig2zxpEJT+LpIA9wst5n+rhsABGanDKYxiZgjbN3FvEL3AFJw/RflZJqhcKBAnSt9tvFmFrZR+Xw3Rug==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rjaTqyhEaKDuyTXt89q0O2FtdXsJd1OXhticyrVz5Rs=;
 b=jf9Qy9ueMekrNfv93YADt1A3OOcdJQoaV2d6zUUz3LEPJwQz1H/P1KlaZKwtmRvNfbJo0AhJSn99iEVe7PizheQ8tU7L6j7fSu4H9Q/4uhGIkp0+LilqC4kG7hqHCbqbWXceYgnNjtI8hg2/GiJaFnr/L0P/UjilhpzDFzlnKxpTnh2cnB9UvL440SapJfPB5UVbfQSwSN9L/2FBjwmBp9D5U7pxvLErcD0N7BlSsz+RY4jup3YTk7RUEayNfb382FwbqfDvh1g/6010431YtYLX9l/qW6qbR1sc9+c5intUI4TlA6suCDT0ZwFkPN27nuu5knXoJgnc1xq7bEE/4Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rjaTqyhEaKDuyTXt89q0O2FtdXsJd1OXhticyrVz5Rs=;
 b=FTC4BTEzsjLVlxkWu0dfDZ2Nx8bNjHHRA8ilq9cTia6HBR0Sq6XuMrepifUb/iAwlx+aFYADJSKmzIvAyxfAPxc0YLO6+6+L/M9ysrjkNI9al93D8T7pUHmoqNmKWdtAskBqSfNidM2kDHvPVJeOqYk+psJAQ4iYxnl5TebZ3Iipmn27a+8PasK8jkNjksQ4kgZGReQd1vzMgSEoB6qU1sk2H2zBiWJgMLYwwRYtKxUeub8WUQUQUlNNaVUtd95vfRLLxiT3lLbuss0aMDNU9dGMnDQCt4Ifoq+h7iUfMEh6DJ+O2Ku5HSgMagHJea7bQ+X3lD3RBRoZBEhGjMOjOA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from BL0PR12MB2353.namprd12.prod.outlook.com (2603:10b6:207:4c::31)
 by IA1PR12MB6555.namprd12.prod.outlook.com (2603:10b6:208:3a1::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9723.4; Thu, 12 Mar
 2026 06:35:02 +0000
Received: from BL0PR12MB2353.namprd12.prod.outlook.com
 ([fe80::99b:dcff:8d6d:78e0]) by BL0PR12MB2353.namprd12.prod.outlook.com
 ([fe80::99b:dcff:8d6d:78e0%4]) with mapi id 15.20.9723.000; Thu, 12 Mar 2026
 06:35:02 +0000
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Thu, 12 Mar 2026 15:34:59 +0900
Message-Id: <DH0LFHAXDCZZ.3GSBNK7DXNDRP@nvidia.com>
Cc: "Miguel Ojeda" <ojeda@kernel.org>, "Boqun Feng" <boqun@kernel.org>,
 "Gary Guo" <gary@garyguo.net>, =?utf-8?q?Bj=C3=B6rn_Roy_Baron?=
 <bjorn3_gh@protonmail.com>, "Benno Lossin" <lossin@kernel.org>, "Andreas
 Hindborg" <a.hindborg@kernel.org>, "Alice Ryhl" <aliceryhl@google.com>,
 "Trevor Gross" <tmgross@umich.edu>, "Danilo Krummrich" <dakr@kernel.org>,
 "Dave Airlie" <airlied@redhat.com>, "Daniel Almeida"
 <daniel.almeida@collabora.com>, "Koen Koning"
 <koen.koning@linux.intel.com>, <dri-devel@lists.freedesktop.org>,
 <nouveau@lists.freedesktop.org>, <rust-for-linux@vger.kernel.org>, "Nikola
 Djukic" <ndjukic@nvidia.com>, "Maarten Lankhorst"
 <maarten.lankhorst@linux.intel.com>, "Maxime Ripard" <mripard@kernel.org>,
 "Thomas Zimmermann" <tzimmermann@suse.de>, "David Airlie"
 <airlied@gmail.com>, "Simona Vetter" <simona@ffwll.ch>, "Jonathan Corbet"
 <corbet@lwn.net>, "Alex Deucher" <alexander.deucher@amd.com>,
 =?utf-8?q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>, "Jani Nikula"
 <jani.nikula@linux.intel.com>, "Joonas Lahtinen"
 <joonas.lahtinen@linux.intel.com>, "Rodrigo Vivi" <rodrigo.vivi@intel.com>,
 "Tvrtko Ursulin" <tursulin@ursulin.net>, "Huang Rui" <ray.huang@amd.com>,
 "Matthew Auld" <matthew.auld@intel.com>, "Matthew Brost"
 <matthew.brost@intel.com>, "Lucas De Marchi" <lucas.demarchi@intel.com>,
 =?utf-8?q?Thomas_Hellstr=C3=B6m?= <thomas.hellstrom@linux.intel.com>,
 "Helge Deller" <deller@gmx.de>, "Alex Gaynor" <alex.gaynor@gmail.com>,
 "Boqun Feng" <boqun.feng@gmail.com>, "John Hubbard" <jhubbard@nvidia.com>,
 "Alistair Popple" <apopple@nvidia.com>, "Timur Tabi" <ttabi@nvidia.com>,
 "Edwin Peer" <epeer@nvidia.com>, "Alexandre Courbot" <acourbot@nvidia.com>,
 "Andrea Righi" <arighi@nvidia.com>, "Andy Ritger" <aritger@nvidia.com>,
 "Zhi Wang" <zhiw@nvidia.com>, "Balbir Singh" <balbirs@nvidia.com>, "Philipp
 Stanner" <phasta@kernel.org>, "Elle Rhumsaa" <elle@weathered-steel.dev>,
 <alexeyi@nvidia.com>, "Eliot Courtney" <ecourtney@nvidia.com>,
 <joel@joelfernandes.org>, <linux-doc@vger.kernel.org>,
 <amd-gfx@lists.freedesktop.org>, <intel-gfx@lists.freedesktop.org>,
 <intel-xe@lists.freedesktop.org>, <linux-fbdev@vger.kernel.org>,
 "dri-devel" <dri-devel-bounces@lists.freedesktop.org>
Subject: Re: [PATCH v9 01/23] gpu: nova-core: Select GPU_BUDDY for VRAM
 allocation
From: "Eliot Courtney" <ecourtney@nvidia.com>
To: "Joel Fernandes" <joelagnelf@nvidia.com>, <linux-kernel@vger.kernel.org>
X-Mailer: aerc 0.21.0-0-g5549850facc2
References: <20260311004008.2208806-1-joelagnelf@nvidia.com>
 <20260311004008.2208806-2-joelagnelf@nvidia.com>
In-Reply-To: <20260311004008.2208806-2-joelagnelf@nvidia.com>
X-ClientProxiedBy: BYAPR05CA0107.namprd05.prod.outlook.com
 (2603:10b6:a03:e0::48) To BL0PR12MB2353.namprd12.prod.outlook.com
 (2603:10b6:207:4c::31)
Precedence: bulk
X-Mailing-List: linux-fbdev@vger.kernel.org
List-Id: <linux-fbdev.vger.kernel.org>
List-Subscribe: <mailto:linux-fbdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fbdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL0PR12MB2353:EE_|IA1PR12MB6555:EE_
X-MS-Office365-Filtering-Correlation-Id: a4f961cc-1f7d-4cd4-bda0-08de80017d92
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|10070799003|376014|7416014|1800799024|22082099003|18002099003|56012099003;
X-Microsoft-Antispam-Message-Info:
	ui8re/SYJzBEP+guBBgkI4CpoxXwO6W4r/seqCcMEQnvXRUSqgg8vNQsf9Y6CflPPUvvyUCopBnwtxIyjq6ssMeutIFEOlchTTN5FMo3GLmunVjCYGucvkLkz+YJ6oylRQD165vQGPc1WW+jyug86fNjv93/AXopt9iGTO/wC5NP/F2D7mGa0JuBvrKOmDoAfNQMRURS1a6l/rvF9Btrc9rlDe4mGgL8t8cQYoCKVWd7DHOXi6jkO05vjSxFPY5GwstG+6IzSohoJRmTylb3O2nzkxtXXyv183LUtRSJaC9vMMrx2ZYBX15mwkXwtsk3N4aMiYy2IXvLtnvAs4uUZROGfZ7mL3k/+Gov/v0+k/ZQ0DSZZ3GOrAbuSBTFLuezL5v/4XuVL8h2MLm34DY59kz+kV3djk7tMPQcpcUaYE2xomxm+ERDypFrzdv/+2K90msw6vBYp/6204smAbbUKbqBK6Og351M0AW81VKaiSYpSe0eS2IHMgV00mVbTHgHIRcaF68oGJUAMSCyKnSc7n3wORepCS+UQdLdQKWlnXxEqnW9TxlydymctnBDcbDDtp2ePtMnW86Z02L8J+kyE4GjHjlK9oz9yq+T5Ip23lxiwuy/6EtXrAbWRMVEDu9RXSi3/mDNFJC8WWUoTcueHRyYUo8pRML9MymMObNFaX4hgThz7SBU4sBS2M1gGX55maYdbkBaXQEQ/ayhCOMpsf9SE/Yhx94W4AR2P+XAZh0=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL0PR12MB2353.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(10070799003)(376014)(7416014)(1800799024)(22082099003)(18002099003)(56012099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?TENpQlp5d0NJd2xUOERoZ0R4aGhXeUkydXhsYnFGOGRIT3N4K0NRbW1oaG10?=
 =?utf-8?B?NWsvZ1hVVG9OUlR3OGZXcld0YXJsTXlTalQvOEE3VHZXWnZQRHdubTBqVGFu?=
 =?utf-8?B?ejZyalZ6dzNYRy8rUE5rN05wMklSRjBXSVZiMkc2UllpYnBITnpXYnNmRU1y?=
 =?utf-8?B?bmttRzJSazFuZGxLVkRxby93Mk51R2htdVNzTGlxbEd1eG05a0o2SlpPSkcy?=
 =?utf-8?B?WVBUWXQ1MkJXZTBJT3ZLbkY4YWF6Z1hLQWdiZlBQTHVOWjU2bldOY1p4OWdR?=
 =?utf-8?B?RURmUlJHTHRNWnB5amhreWtxMWxaWFQ5eWU4SG9PdUhDcXN1bi9EeXJlbXN3?=
 =?utf-8?B?UldBb0FqNitVeXBFOFU4WS9mdlZHS1Y0UTc0UDgvMlczdGk4VXhLSjhnSldj?=
 =?utf-8?B?R1RwTzBGNy9iT0tWaytWYm00dGljU0RMZ2tZZUd6OXhOdFZwQUdDN0kwVTJO?=
 =?utf-8?B?RlBJUUExR3RSWlI0VWxqbGE2a3lvV3ord212b3F6emFSM3ozZUtPMVVyamNC?=
 =?utf-8?B?Y2ZKS2VEWGhTQ3g1UG1vVWhOcStIMFZsOWdDVjY0dHJUQUdMZG95NlhodmFw?=
 =?utf-8?B?VXFHaGFJN2s3RlZtUDdhMTYxZGNkTjR5VEo3d1R6TVZLemI5U1Q3ZG4xZWp3?=
 =?utf-8?B?L1FveXpPZlp5eElONTM1dTZtd01rU0hMN3Jqb1B4d1lUanZjTGxiSk1rREtC?=
 =?utf-8?B?cWd6cDMrWEVUZDZ2ZG5OM2ZMMVZaTVZRSDdBVDF4eG1sWXFoT1ZJZWN4N1Fx?=
 =?utf-8?B?UzVaVXUxYlA0U1RNYmo5dTM5a0I2b01BLzNqVzNCanYzZWxGZ3k3Y1lzZVg1?=
 =?utf-8?B?QU5tSEZPM0hLZDJwdkN4NkV1d2NnOUo2K2xzNFFnZWRabEZWTkpVWW5KUUg5?=
 =?utf-8?B?ellsTzZNMnUxYTRtS0VyUHhDRHVFSStObXZiY3FBZlJ5Q0RteEYyRjlGb01s?=
 =?utf-8?B?L2dnTmpseDZ1NWpHUUp6NVEycHlGTGpidjNZSzM3R2VOc1FwZEd1bC9TTURU?=
 =?utf-8?B?YkYxMEJWajgrSGJ1bDdVd3g4T0tJYk1wUDhWQjBEK2w5UWV5L0FWR0krNGhR?=
 =?utf-8?B?aGNMeTNZZGpYQkcvU20yUFozMmVYdVZtMU1EeGRxZzkrVFlzTUpnL0FSVlZj?=
 =?utf-8?B?UkNzTWJnOXFXNU5qOVE4MWppckxkQU9OS1htUUR2RE1MS3hSVzBWYUY4eWxz?=
 =?utf-8?B?dG54WXhSeS9QMHZzNy9DNXd2WmlOaGtzM05Db2tIWjZzUFhCblFLZSs2eTNP?=
 =?utf-8?B?L2U3UTIyNEIzRWVzQi9QaUdQZHA3M21xTS9aWE4wMDBRZWFaYzBFcVFNOEhy?=
 =?utf-8?B?L0xHR0dTRUF3V1VHVThWUnFoMlkrOGptT2RvTm1QazdYaVpXWWtZQUM1SCsw?=
 =?utf-8?B?ZXJTRTNCVyt0NEZMNEFSR3JSVGkxUnhjc2NXamNTcUFpWmV6a1hDRFROSjVU?=
 =?utf-8?B?dGNoRHlpWW1ySTBldHU3NTZaNDI5WFNyazBsZ3RsK0tYaTRSeFcxL1dHa25V?=
 =?utf-8?B?RkEyNDJadm1GNjFaalZXcUxxL2s3cmQ3TCs2cFpnS0FqZ2wyNCtlMGFSVmh4?=
 =?utf-8?B?R1ZTajB4REZQeUtDQ2krNEZQT0Vzc0xoaW9aeWtiSmtXR3dVL05ZNFRpbEo5?=
 =?utf-8?B?WDFkd2M2NHU2YXJRcU4xeVNFNzYybE9jLytGY3djczdrY0I2aUdkQWNtZjlr?=
 =?utf-8?B?VlpjcHdMYy9oNldlZU5tV2MrWVJ2YW9PUDZDb0NkUWtQUUI2cFBPL1lwZm5h?=
 =?utf-8?B?M2tMNzFQaWw3UUdQUG1TQmpxYm10THJGWGJZUEtoamxFbkFUQVBVektocUpN?=
 =?utf-8?B?Z1Ayb0NFQWdXb2pPMUNldjRYMVZ6aVJpUWFQOHFQZGMySW5OOUNicUI2VjMw?=
 =?utf-8?B?U2djY0ZDc010b1RPUjk5NEw5OVBrNy96L2N0b3hXMGtVSVVOcUloemhqc3Ft?=
 =?utf-8?B?Rm9FYmdlOEhCZkhqL0VUQTZVMko3T21GYU90Vnh5U3lybDgwZE5Xd0lNSmlF?=
 =?utf-8?B?c2xLeWZMc3J0N1JwNnVnTGM1QlNNZk03NDQxdW9ZeG9yYzJzWURNaFhIZU1W?=
 =?utf-8?B?VElHTFU4OEpJNWliUUE4WnJhVFVLRmYvS3dhSlVQSlpnUklQS1RiSW9zSnlj?=
 =?utf-8?B?MEJTNVViTWx1ckxRVVVBNVhvMkpYNWpTQnBmQWVNdk1jZzZydWtVR2RkRito?=
 =?utf-8?B?QnovYWh2OTc4OStGUDNDVUg0ZFNXN3RSV1J6bEdUdW5vNnJ2c1RtWnBySndG?=
 =?utf-8?B?RVliOXd2SHR6VHVNVzhlYzUyd0c1K01PQlB6b3RZUTFrSkFlQnpsUWdBOWlu?=
 =?utf-8?B?TGhrUGpQL0YwcGpjbUZJeXpCYjdnVkM1WHJiZVhVMzFLaW95RWxCZW1NUmNs?=
 =?utf-8?Q?79UalDy+bBPgov5RHlfE/JT0ICii45DnCCXMcZPEAjIUd?=
X-MS-Exchange-AntiSpam-MessageData-1: XD4w/Ds9sPmjYw==
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a4f961cc-1f7d-4cd4-bda0-08de80017d92
X-MS-Exchange-CrossTenant-AuthSource: BL0PR12MB2353.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Mar 2026 06:35:02.5059
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ZlZOztvg7Y8+rGS+cGtpbSCHTl+63rTN54vgjwiaJXQCCeP0/BvxDp7pmcwXk0o9boLS6GXfzCp9GVKbubQLUQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB6555

On Wed Mar 11, 2026 at 9:39 AM JST, Joel Fernandes wrote:
> nova-core will use the GPU buddy allocator for physical VRAM management.
> Enable it in Kconfig.
>
> Cc: Nikola Djukic <ndjukic@nvidia.com>
> Signed-off-by: Joel Fernandes <joelagnelf@nvidia.com>
> ---

Reviewed-by: Eliot Courtney <ecourtney@nvidia.com>
