Received: from DM1PR04CU001.outbound.protection.outlook.com (mail-centralusazon11010002.outbound.protection.outlook.com [52.101.61.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 418AC31D72E;
	Mon, 16 Mar 2026 04:34:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.61.2
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773635670; cv=fail; b=LS+hUZUMwT/IDqcx/hyEUy5Sjwd3qruR+6sCS80q0CBBN2OLvduC8K/JE8OnMXaNAxOKEq4Q4qWQrTFtnOw4ZL51lga0f2YqOkNmYkf86L3fx8Bcbwix5Bs3ynUpGLl4DN4R5ZYDdji8Jv39GchP6zYIt/vcJxGiYwbsmHhD/4A=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773635670; c=relaxed/simple;
	bh=DjnM5bY1zfudZXoY+hvOzX+0I4U7yoOxpSQJVRkuG1w=;
	h=Content-Type:Date:Message-Id:Subject:From:To:Cc:References:
	 In-Reply-To:MIME-Version; b=h/q9j9NJv4I9O6htCo2NEhGYUEqP1asg5dWrX2Z0bD8Q+G6mHiUlGQN9mvWzgFQlSzaNkygYIeCqNhCgQq6NRRCPOhNgy8/xkH2Sp9/Usu8yMwVkgR7d5DBllOkfsCfP9MWd9iaz/POkWWFwEqY6lI+AiVPbGftjr987FmM1st4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=Ayhk0WBc; arc=fail smtp.client-ip=52.101.61.2
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="Ayhk0WBc"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ptPA7+ATxVJtTNc0jw1h8Ptyx1mUPKqpaTyQ7XFsKl8/XwHmVh/drOf889Ibpta/8SUgGto05o8pXsH2DOHSP85PCILbQPNiNbo+EhCMo9TxyfVYsH5ohNjSmuj+QzU1E5Ur6ykF94l4DBn7qCqR7qCO6SSqjcWJOxdlyIPxGfdnH4YYbNZnpc845uJBb13M6g3tEcteD0wX4ipAw4cKAAMCErDqfVdbEpCUaxa9Hcg1V0Ml7ugYzJ+99Ol8BhuzPthw0rwadcwzgjv0dAcWpEFr2/I7cbLcyRQufTam4f1PoZF3o1Vxb997W6MULctGnZfHhPi+Y6ATMA6HsOCJ/A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vLAOWr6EV8ec+ztoApO3bq8IdwHVFiqzPOCDjQVoHxw=;
 b=otO4r0kNuFfGqUN3SG8EXfHvcz0O+fflwCY6vePBhrZ+7uSpDBPp0YI1xOUIP6Cgsso1v+UYIwYaT2avvslxgu0Gh41hqEFtSbVnO/oRNJqPzm3OI9Q96lU6D/Wvrc4tUcMpns5ARQq+Kd7+8GOU+zNK5QkH9iU81VcF65DE1tCrxAFnCd2r8sqzcxiLzv1sOmFIuDM2vbiYYHbjkNkRvLRP8WxuLyrtKMRVaXaqSd70xLsOkZXIKWjmd/POstyyGG0suoV2mT4qazYv+GSig4gVM78FemnPI38nLM1VU2rNc6/781VXFdYkfkAd0H+4/fsCfUaQFIVNgImqXXm8sw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vLAOWr6EV8ec+ztoApO3bq8IdwHVFiqzPOCDjQVoHxw=;
 b=Ayhk0WBcMpJvjY8+bJ4lmpulBKcbuKZdvr+LTz7aOU4niJI6NGgkxYNy6YTQW8djbtZf12PRIyjfMv7eHJuNKfyRVmZnxgWbw7EZF4VQ2FE5yHvj2q1e5gSkvtEHMG2TiEKxRhCmAEMSECFD7LlkMqCxlgCRmV5NK32B6/QbsLIBLuZcfM0zx3cp0UXwTJfq+5L0pW+Q6y5vHm7jDZv1gNFYuPi7m03zjR/2qhmAt9VwH7PA93ak7aEVKnkHB0ATDVK8iR4ANarU1OdrmlKW7Sb/sBuXGWPOaLyYfk7oZaFIYRMHiLJhzl+id38LYpkKcRIcd02XUnB5tf4htDLyhw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CH2PR12MB3990.namprd12.prod.outlook.com (2603:10b6:610:28::18)
 by DM6PR12MB4122.namprd12.prod.outlook.com (2603:10b6:5:214::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9700.11; Mon, 16 Mar
 2026 04:34:21 +0000
Received: from CH2PR12MB3990.namprd12.prod.outlook.com
 ([fe80::7de1:4fe5:8ead:5989]) by CH2PR12MB3990.namprd12.prod.outlook.com
 ([fe80::7de1:4fe5:8ead:5989%6]) with mapi id 15.20.9723.014; Mon, 16 Mar 2026
 04:34:21 +0000
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Mon, 16 Mar 2026 13:34:17 +0900
Message-Id: <DH3XD8NUDJNG.2IMPYC40D8DXI@nvidia.com>
Subject: Re: [PATCH v12 1/1] rust: interop: Add list module for C linked
 list interface
From: "Alexandre Courbot" <acourbot@nvidia.com>
To: "Joel Fernandes" <joelagnelf@nvidia.com>
Cc: <linux-kernel@vger.kernel.org>, "Miguel Ojeda" <ojeda@kernel.org>,
 "Boqun Feng" <boqun@kernel.org>, "Gary Guo" <gary@garyguo.net>,
 =?utf-8?q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, "Benno Lossin"
 <lossin@kernel.org>, "Andreas Hindborg" <a.hindborg@kernel.org>, "Alice
 Ryhl" <aliceryhl@google.com>, "Trevor Gross" <tmgross@umich.edu>, "Alex
 Gaynor" <alex.gaynor@gmail.com>, "Danilo Krummrich" <dakr@kernel.org>,
 "Dave Airlie" <airlied@redhat.com>, "David Airlie" <airlied@gmail.com>,
 "Maarten Lankhorst" <maarten.lankhorst@linux.intel.com>, "Maxime Ripard"
 <mripard@kernel.org>, "Thomas Zimmermann" <tzimmermann@suse.de>, "Simona
 Vetter" <simona@ffwll.ch>, "Daniel Almeida" <daniel.almeida@collabora.com>,
 "Koen Koning" <koen.koning@linux.intel.com>, "Nikola Djukic"
 <ndjukic@nvidia.com>, "Philipp Stanner" <phasta@kernel.org>, "Elle Rhumsaa"
 <elle@weathered-steel.dev>, "Jonathan Corbet" <corbet@lwn.net>, "Alex
 Deucher" <alexander.deucher@amd.com>, =?utf-8?q?Christian_K=C3=B6nig?=
 <christian.koenig@amd.com>, "Jani Nikula" <jani.nikula@linux.intel.com>,
 "Joonas Lahtinen" <joonas.lahtinen@linux.intel.com>, "Rodrigo Vivi"
 <rodrigo.vivi@intel.com>, "Tvrtko Ursulin" <tursulin@ursulin.net>, "Huang
 Rui" <ray.huang@amd.com>, "Matthew Auld" <matthew.auld@intel.com>, "Matthew
 Brost" <matthew.brost@intel.com>, "Lucas De Marchi"
 <lucas.demarchi@intel.com>, =?utf-8?q?Thomas_Hellstr=C3=B6m?=
 <thomas.hellstrom@linux.intel.com>, "Helge Deller" <deller@gmx.de>, "John
 Hubbard" <jhubbard@nvidia.com>, "Alistair Popple" <apopple@nvidia.com>,
 "Timur Tabi" <ttabi@nvidia.com>, "Edwin Peer" <epeer@nvidia.com>, "Andrea
 Righi" <arighi@nvidia.com>, "Andy Ritger" <aritger@nvidia.com>, "Zhi Wang"
 <zhiw@nvidia.com>, "Balbir Singh" <balbirs@nvidia.com>,
 <alexeyi@nvidia.com>, "Eliot Courtney" <ecourtney@nvidia.com>,
 <dri-devel@lists.freedesktop.org>, <nouveau@lists.freedesktop.org>,
 <rust-for-linux@vger.kernel.org>, <linux-doc@vger.kernel.org>,
 <amd-gfx@lists.freedesktop.org>, <intel-gfx@lists.freedesktop.org>,
 <intel-xe@lists.freedesktop.org>, <linux-fbdev@vger.kernel.org>, "Miguel
 Ojeda" <miguel.ojeda.sandonis@gmail.com>
References: <20260306203648.1136554-1-joelagnelf@nvidia.com>
 <20260306203648.1136554-2-joelagnelf@nvidia.com>
In-Reply-To: <20260306203648.1136554-2-joelagnelf@nvidia.com>
X-ClientProxiedBy: TY4P301CA0090.JPNP301.PROD.OUTLOOK.COM
 (2603:1096:405:37a::12) To CH2PR12MB3990.namprd12.prod.outlook.com
 (2603:10b6:610:28::18)
Precedence: bulk
X-Mailing-List: linux-fbdev@vger.kernel.org
List-Id: <linux-fbdev.vger.kernel.org>
List-Subscribe: <mailto:linux-fbdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fbdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH2PR12MB3990:EE_|DM6PR12MB4122:EE_
X-MS-Office365-Filtering-Correlation-Id: 4533d80c-50a7-47d7-e14a-08de83154ab7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|10070799003|1800799024|366016|376014|7416014|18002099003|22082099003|56012099003;
X-Microsoft-Antispam-Message-Info:
	76T5UEpTilXP3nXHqX0fqibe3qa6fUue8qhAlc0Utd23NnYSkHBB0ES4TNIOq1JUGlgW2oYCHSiPA51s/mflbF3qRVjsunXMU/9eM/LWqxbld5GVeVJmbybNbPmiLzw1ZoqQ4JzbrIpFql5Gp/jTiw+nPZ5kv6UWh006I7rbOr3NsCP/8ahFB5E+T/jeiXk/0Yj01OCSzV8pY84U6ZTQ2Ojz7K3fCO6Kdlh0mrQk9ppJVo28GmoWkcNNloL8DXaWD9RibP2gcLKu2g9wlLZsH3uRn/Kwaq4ekHKNhs3yqXEU+EwJK5s4yR01SJ93XttkYq7ZGepcZxjUDUS+ueGThWXWqw4b9A8AV0l1EubG/+dhOBgvgS4TxFlPmy6GuFO+UXdj2n0mzFSzsYIomg57slrR5m1N9TJjBRbzkCWkSblXMUgGeFrN7UoMLS0DBjYgIVScEawBKQRb/li61ebIt6Nk4kAdbhYuMxDFaJr3T80nK+aHMnj3lgsdGXK0qW3H2ZDfTv3KXemEHGaZ3WsHSNmoi1huEvcz5QtRvbgRdZMrGOJzQ47b1Q5lJbQv0VdtZx+nSeiZ8J5Y+uvT+qQuBKC3FVnV9EEkfycosBd4fpqgIXraQWXi+m4vwuD48h0OkQrOGFIuiy8cqZrxkkzak/e221LeoT+NKq5ZY9znk5506c05d6dXBj+SE+/09iP74W6cK+QQtOIwraSigkB44KVevkarJmPmHehh+ea8wks=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH2PR12MB3990.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(10070799003)(1800799024)(366016)(376014)(7416014)(18002099003)(22082099003)(56012099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?KzFYeXZUb1hKY0h3cXc4bjdrbUsrNDl0NEgyOFd3WEN1YUVuU3IreTZVdlBP?=
 =?utf-8?B?UDZMdjRxWTgvUkRBVkpqUGljdDZqWnEyZFIxSTl0Q011V2o5NDVKc1RNbjNa?=
 =?utf-8?B?ZVdUTTNxQUdHcWNnRkkxWW5OL2RGRjVKRmdrSWM4aEdkUHQ0aHk5d3lvQTNz?=
 =?utf-8?B?ZkV3VWJYNEV0azBFU3dWWnFWVlJrN1hlOVFibUY0VUtxZlNxVWZaTGlGc1ZF?=
 =?utf-8?B?SWtjQjZhRkhlRUNFUFgzR2YwMjAxemxZZk9EQjFBWHN5K2FQb2F2aDJ5UG9u?=
 =?utf-8?B?N0x3bzBrVFE1Z1VRSVhab2grc3VqanM0RFZKZm91WHhPc1lqYXROSFRqRVlw?=
 =?utf-8?B?MkVNbzF1allZZzFoTk9VbGpVSm1VVWhubVY3djc3SlpGSlhzWXY4VVI4bWNt?=
 =?utf-8?B?L3ZhRjVTMG80d0djallwUXZUbUo3SmdLbkh3YXVIeG9yUXdsSithQld0TGN4?=
 =?utf-8?B?dnlOZm9RMlVsbTRGbWZRVnA0TmpLSnkyS3A3bjlvL0ZvNGpNdGkydHRkbU95?=
 =?utf-8?B?Vlk2dVJDc2dRTFF0dTRmUCtERjhCcC91NUJyaWxIZmF6TjBKTUl0RmduR0Jx?=
 =?utf-8?B?VkZ4K3d6WWhrQjJ0dlkvM2xzUDN0MmhZNmtQL2xRakVJTjNQaXdueEozcGVI?=
 =?utf-8?B?eG1aelloMDIyVWpNcHl1dlNDYU5Kamtid3ZOM2g2all0NnBJRlhTcUR2ODdY?=
 =?utf-8?B?aWtEMEdIYjBYOFBmelY2YkkvQTQxU241TGE2UloyZ0IxQWpCcFBXd2o3b2Vh?=
 =?utf-8?B?RTZTbzkxNE5YY3ZXbkFDVjFZQnZDU0NNa3gycm41eGE0cnR1bVVUWHZ2OXFG?=
 =?utf-8?B?eXE2OC9EeFU0cXB6N2VXendRb3ZJM2FqSWJmdW9pSEJ5UE1uSXJ5aWpmRCtq?=
 =?utf-8?B?T0dnNVRIcTE2TGlRcjJqVXJvUTdQVURrOUQ1YnU4YTN0L3U5SE00R3NTdDdT?=
 =?utf-8?B?Tm80aldQVjg2dExzajFua0xVVXBtMWtTZk1rSG5LM29XVHlzSEh1YThnWEN4?=
 =?utf-8?B?OFhqTFJGV2w5TXV4RER1MHNDOVhNbjBYcEJFTnB6VDRMOGw0TFVXak9ZSVVq?=
 =?utf-8?B?ZVVnbWZLOWlQVWh3dU9XSlFDbmVxeVdIY1lsU1hMaDA4azd6WVFpYmRQamtD?=
 =?utf-8?B?dWxQWHFFejdjb0kvLy9RWEc1L2NCUU9FeWhqWUZKaTNNUXU2Q2t2alF3bHdk?=
 =?utf-8?B?ajlVL3BJcVYzakI5N1l1cTFFQXRSbDRiMjZMdU5LNnprNFIzWm5GMUc1d0lH?=
 =?utf-8?B?TnZsTUt5dGttTWxnU0RlRmtocEpIdTFOdUJmamw1NWc2a1pNajBWT2lPOURD?=
 =?utf-8?B?RnJFL0Z6ZzBaQ0d2eUZ5QTc2TlREUkZOY1oySlFybCtJNnNBUWNUOUc0QXUy?=
 =?utf-8?B?MjV3cEVrdlJPV3orTzBZT0RreGRDckRwZVB1NzZhd3lpYW5tNjFlbEhzaUJy?=
 =?utf-8?B?cUlMbUJxRXhyUHBobUJDb3VXWG1rNzFKZXV4NTlkdkVta1BaZHMrZ3o2WU4z?=
 =?utf-8?B?L3dGdHZKTmpTbWtCZU1NVXNXZzJldTJEMDU5czQxRnV2NmJySU9DUDR5eTVT?=
 =?utf-8?B?NUFjS0pwZFRjMURuYUNQWDJwYm9nZ2NlR3IzK2xpR1c5c0k2T3FnMkFJRmpW?=
 =?utf-8?B?YUtVbHJyT2djWllGRVJ2ZzI3REN4R0FBZnNEdEtQN1dqYmdVREV5dnVudnMr?=
 =?utf-8?B?U2FJeGJGeEpSNExHaFNtdXVJZ09EaUlBeHpPa1RlMVNuVnlLRXBjMDRhUXc0?=
 =?utf-8?B?QlhCSm9kZm4wQWMyN1pBbThHSWNWWWFROG5EVFpOM1NOakJsOHB1eEU2K2lH?=
 =?utf-8?B?Q3pkbnVQM3FQY2lEZGZRaEpTRFAvMVRzRWpsTUdaaTBYaWh3VW5IN1pSdUlP?=
 =?utf-8?B?VGlGZVlKUzBLMDJwTzEyTU1JUjlRUGZFREFUdzlHUncrR3UwNG0wOVVXRnVD?=
 =?utf-8?B?K3B4dVdtVzFUbWRmTkZEQ1I5c0tuaDhpZTZHbDB0czZGd1lwdU1EdHFpUW1B?=
 =?utf-8?B?Q0dWZUJpZ0lseS81TUwwTlhNUnFWZ25zQzBsb01mUXJQRHBXM2VFbWtmbkFa?=
 =?utf-8?B?NlhySW96ZGVLTFhDaTZPOXI4YzNJOWJOUUlIaEo0REY3M0w1VDNpVGY2Smkz?=
 =?utf-8?B?YXFvYURMazlnbzZqTDE4QnhrRWNXeW1hOGJyVUZRcXczRnNoYmZiOGR2WXl3?=
 =?utf-8?B?Qk5UeTJyS21VazAwQ2o4QkJZblZsY1E1UUh0OFN6ZlkwbkNWNXAvbUQwVkNu?=
 =?utf-8?B?V3B6c3JOcHIzeGFuTU1kT1YxdWdjY0NSTWVJbmdpbjJjRjNrTllDc2dTN0py?=
 =?utf-8?B?SjZZYW42RnAvb3pTQkVnWjJuQTZDN0M1Nm15M3ZjVStmOEFGSDRSOEc3QW9m?=
 =?utf-8?Q?KVsUbxOgdRrwgZY6+5gbpUtUtT1jBnqZy/3JoP7cxkOwO?=
X-MS-Exchange-AntiSpam-MessageData-1: 6J/6okws/1mo7A==
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4533d80c-50a7-47d7-e14a-08de83154ab7
X-MS-Exchange-CrossTenant-AuthSource: CH2PR12MB3990.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Mar 2026 04:34:20.7388
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: nmXihOcwuGppbO2DNVgXdfvvWhydbOtaJ64dbv75Fn1OAfT+uKuLjZU0fvjxHl9McWy3J/2gFB/eVD0bwEUaOQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4122

On Sat Mar 7, 2026 at 5:36 AM JST, Joel Fernandes wrote:
> Add a new module `kernel::interop::list` for working with C's doubly
> circular linked lists. Provide low-level iteration over list nodes.
>
> Typed iteration over actual items is provided with a `clist_create`
> macro to assist in creation of the `CList` type.
>
> Cc: Nikola Djukic <ndjukic@nvidia.com>
> Reviewed-by: Daniel Almeida <daniel.almeida@collabora.com>
> Reviewed-by: Alexandre Courbot <acourbot@nvidia.com>
> Acked-by: Alexandre Courbot <acourbot@nvidia.com>
> Acked-by: Gary Guo <gary@garyguo.net>
> Acked-by: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
> Signed-off-by: Joel Fernandes <joelagnelf@nvidia.com>
> ---
>  MAINTAINERS                 |   8 +
>  rust/helpers/helpers.c      |   1 +
>  rust/helpers/list.c         |  17 ++
>  rust/kernel/interop/list.rs | 338 ++++++++++++++++++++++++++++++++++++
>  rust/kernel/interop/mod.rs  |   9 +

I think I have mentioned that in another context, but the standard seems
to be to use `interop.rs` instead of `interop/mod.rs` (Miguel please
correct me if I'm wrong).

Also, and once again, please, please build with CLIPPY=3D1 before sending.
The buddy series also has clippy warnings. Fixing them before I can
review is tedious.
