Received: from PH0PR06CU001.outbound.protection.outlook.com (mail-westus3azon11011070.outbound.protection.outlook.com [40.107.208.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE3BA128816;
	Sun, 25 Jan 2026 01:51:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.208.70
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769305894; cv=fail; b=LSptmbiNdsU/fNOezeVNFq2sSU+ZNAI+UggOWgThaBHszpv+eC9/wBVgFadbdByj+pILxb4tNTchFzbv+plm77jbWhXdsplComfrm3ZHO4fC6F7AL8Ft7Pd8+MxgMnwNYQRatEfHhZ4bcOscu6EFfWn57k/xTwA3oFgP9dvXN/Q=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769305894; c=relaxed/simple;
	bh=SF3EDJmKoH0kBpPCWjuh7Q4JnmU3q8A4qnC9793MWn4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=eF8r7VfqGBQRmNRzIGpczEL/5dApUWDuVZay4QgTTZSlFy5470qsl1K+dxLRthy6DY01ztAqoJ3m41RzdgYXRvsiemxFJ+YvmB8YGFW4IQMpADyYyrtePg98jS4tIkpEATZ0Gt+dshMqhNmIURepQlA4NF+agX0R4RJ3L7DZbA8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=Ul12KzdS; arc=fail smtp.client-ip=40.107.208.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="Ul12KzdS"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=wzxIpk0frLoTLPKqNJqNcwZRyDuxtGS8V2RXEbVHNGVcWIbJrEvTEsMZOkOQKken5U75HzbZebt8GjU/Xexd1jlqzTKyauSlJLrZLLfxcdHKIM5UWZrQzTR6Z8s7N+RpsziCS3hyGOiz8zTwRdUZSdPsKuS6YKqK+nQ7ZF/N73ImmtS8k+ISZBE9vMSVitUEdsIEET891xYMU2CqTnLrdsPeJYKBYJsjH76WZwWay5+59T+mF0yFlkNLq39McpI2M0ezuWjQp5jCBrIIJOnrJkG5cHz78UgQGt30jzUJV0z1E5lpgEiivPfTGWujAV7OMETWzcisArOhAJ4tnrRmgg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LkdAEm3nHzcBkuZwK4qjsA87mv3h5tKuVVxpMMBwP1E=;
 b=P7w4XjMxjX/YNLX3N2DjvJgORswK/b70uo+vDpKKsij5Qli8Jh7qT/EUdp8dYeFB0l8xxfAnvhml+TvPeckP+aT4V/Dhdbs0FnhqQ4hihnf2NSOLkksOHuZxPtH9Jyh/8lLtZmG/GdankzDffefRKZmkIv4HWJIRkQdnqG1Q/o2qj24FXL9G+fUXoqbURin7sgZWEk96WyHNf2uk+WL3qE5VEmlt4/pIevw3F9Yrcp5Jyi0Ze5hMyXWXCm7pUleAxNHFc/8ZxoSAjKi9ldy+IAdnhQSbB0jBG1qVQcuhsRta7ZlpwBOHP/2SgBPfzmxuyUYDQkyeoho/3Y2r7vRw3Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LkdAEm3nHzcBkuZwK4qjsA87mv3h5tKuVVxpMMBwP1E=;
 b=Ul12KzdS2CoMKeWFQ24wVMuiLQ+tZ7WKiqJPC7HYHAf50D2sE6EjpyDriYzzaBedd1KnKGPgbxPCsNbdWtudKAshpcaIySowxzZw8zjWTE3bqjALFtWwYx7VB62Dcbb7UhegH2v6xTy3KhoUm/fNmPRPsLkej6Hl+x7v+tXM0IcxzMzipjdMUByJIOKcalOtrk5nJK5pZVJnRl3UJMeZguEDchpxCtAvD+qtGmmCjCYVUbGiGdzuRoGArklhn4mDHwj+PwvyngLUKJVwHzM/SKsV8ZlJzWjxe1ZzAWuoy8iZchQ1yC/7o0CyNoyZzl7TLUVuUPbu8B8Y0+AXcgQMnQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DS0PR12MB6486.namprd12.prod.outlook.com (2603:10b6:8:c5::21) by
 PH0PR12MB5630.namprd12.prod.outlook.com (2603:10b6:510:146::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9542.14; Sun, 25 Jan
 2026 01:51:28 +0000
Received: from DS0PR12MB6486.namprd12.prod.outlook.com
 ([fe80::88a9:f314:c95f:8b33]) by DS0PR12MB6486.namprd12.prod.outlook.com
 ([fe80::88a9:f314:c95f:8b33%4]) with mapi id 15.20.9542.010; Sun, 25 Jan 2026
 01:51:28 +0000
Date: Sat, 24 Jan 2026 20:51:27 -0500
From: Joel Fernandes <joelagnelf@nvidia.com>
To: Gary Guo <gary@garyguo.net>
Cc: linux-kernel@vger.kernel.org,
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Maxime Ripard <mripard@kernel.org>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
	Jonathan Corbet <corbet@lwn.net>,
	Alex Deucher <alexander.deucher@amd.com>,
	Christian =?iso-8859-1?Q?K=F6nig?= <christian.koenig@amd.com>,
	Jani Nikula <jani.nikula@linux.intel.com>,
	Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
	Rodrigo Vivi <rodrigo.vivi@intel.com>,
	Tvrtko Ursulin <tursulin@ursulin.net>,
	Huang Rui <ray.huang@amd.com>,
	Matthew Auld <matthew.auld@intel.com>,
	Matthew Brost <matthew.brost@intel.com>,
	Lucas De Marchi <lucas.demarchi@intel.com>,
	Thomas =?iso-8859-1?Q?Hellstr=F6m?= <thomas.hellstrom@linux.intel.com>,
	Helge Deller <deller@gmx.de>, Danilo Krummrich <dakr@kernel.org>,
	Alice Ryhl <aliceryhl@google.com>, Miguel Ojeda <ojeda@kernel.org>,
	Alex Gaynor <alex.gaynor@gmail.com>,
	Boqun Feng <boqun.feng@gmail.com>,
	=?iso-8859-1?Q?Bj=F6rn?= Roy Baron <bjorn3_gh@protonmail.com>,
	Benno Lossin <lossin@kernel.org>,
	Andreas Hindborg <a.hindborg@kernel.org>,
	Trevor Gross <tmgross@umich.edu>,
	John Hubbard <jhubbard@nvidia.com>,
	Alistair Popple <apopple@nvidia.com>, Timur Tabi <ttabi@nvidia.com>,
	Edwin Peer <epeer@nvidia.com>,
	Alexandre Courbot <acourbot@nvidia.com>,
	Andrea Righi <arighi@nvidia.com>, Andy Ritger <aritger@nvidia.com>,
	Zhi Wang <zhiw@nvidia.com>, Alexey Ivanov <alexeyi@nvidia.com>,
	Balbir Singh <balbirs@nvidia.com>,
	Philipp Stanner <phasta@kernel.org>,
	Elle Rhumsaa <elle@weathered-steel.dev>,
	Daniel Almeida <daniel.almeida@collabora.com>,
	nouveau@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
	rust-for-linux@vger.kernel.org, linux-doc@vger.kernel.org,
	amd-gfx@lists.freedesktop.org, intel-gfx@lists.freedesktop.org,
	intel-xe@lists.freedesktop.org, linux-fbdev@vger.kernel.org
Subject: Re: [PATCH RFC v6 01/26] rust: clist: Add support to interface with
 C linked lists
Message-ID: <20260125015127.GA66441@joelbox2>
References: <20260120204303.3229303-1-joelagnelf@nvidia.com>
 <20260120204303.3229303-2-joelagnelf@nvidia.com>
 <DFTTGUYGY72V.3VLVSCB2OOXIB@garyguo.net>
 <01a981f1-64c7-4504-b309-45a024258fe9@nvidia.com>
 <DFUK089V1IEU.U83YQT72BO3@garyguo.net>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <DFUK089V1IEU.U83YQT72BO3@garyguo.net>
X-ClientProxiedBy: BL1P223CA0010.NAMP223.PROD.OUTLOOK.COM
 (2603:10b6:208:2c4::15) To DS0PR12MB6486.namprd12.prod.outlook.com
 (2603:10b6:8:c5::21)
Precedence: bulk
X-Mailing-List: linux-fbdev@vger.kernel.org
List-Id: <linux-fbdev.vger.kernel.org>
List-Subscribe: <mailto:linux-fbdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fbdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR12MB6486:EE_|PH0PR12MB5630:EE_
X-MS-Office365-Filtering-Correlation-Id: d8e5a34c-df46-4119-fd68-08de5bb44130
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014|7416014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?OAg+17xFg4OBPaIAwAGAd7xZn5vMG9FjnrOwECfM3iYJ9j4tw5UuIGBtswb9?=
 =?us-ascii?Q?rQ42V9TfqtNdmH+ROX7jhxZsbv9bk0D/4gcK05rtwfB2dV4E55+j00teYmG/?=
 =?us-ascii?Q?adsWgzWzWtaVg4Ch9mW4HtOKmeQe8PxbEw/7+k344qtu2Ito2nApX4brFGCp?=
 =?us-ascii?Q?3WtCIbnjEY5osGVt+phVzM8nrd6958Ka99ytaFv5G6UC8nWZCR0K650Dr/Mp?=
 =?us-ascii?Q?rdyjU+IZNwVFj9rRVUvuZnOY/WeNFCemwuDdwnJGWQB+BfLWKiVU1El3361I?=
 =?us-ascii?Q?cOZ+SZKs4Ryi3Zsh3+hS8n3zRv/VUAYbleS+anAVT0L+X3AbKJwIy2R6cWIi?=
 =?us-ascii?Q?W2xUmQOHmOrTjCGO66utSZksE9W0JQTeY55AW3WtHQcx7y4cBHcXvVNWc80J?=
 =?us-ascii?Q?pQxUKplm6mOoVDCErmskt3Cz9p2u26xxt7VLEq1srkix7Ux9uUg/C91a++1J?=
 =?us-ascii?Q?GfdXJFg/1/MlNCpHRML/sal2tALmjawUey7kELWfwAbJhORt0M2YU9TRtoi8?=
 =?us-ascii?Q?MVxwpvzxYOOmk+nrCTK/o0Mhxe0PlOew0VsQyADoKBNODPG2Y8+lDMNyCzOd?=
 =?us-ascii?Q?vl0v4U4w2vVz4ivf+dJ7Lw6AA/X8eErNDY8ZWP1oYqQtszNCopO38jdCFX7c?=
 =?us-ascii?Q?98w2zRpytYaCoVMJavfj3MlzTvv12VkYwr8Zrvemv9WdloRLzkehDfcKGLWA?=
 =?us-ascii?Q?gYmaq0Nd1lntI64c2kDrgJrknIzrZtwZ6LO+KuNGiY6SIjVUgPtgDkj8J4Ay?=
 =?us-ascii?Q?CO2Hu0rFs69Flr/9ZSt6sz9NGS3zBEMOS2LnhVYWgX8OBBKYy45FMQQycFtl?=
 =?us-ascii?Q?/VbRzcSlIdMHeK622S8DVlqMOWg7tvkxfOoAa3haYgqJkP0fNTSA8vaHldiB?=
 =?us-ascii?Q?nZq3dk4fa8pUHh0mjO+GGBnVEXn61PiYYWzpXKlD962+yzobhRf9/xFQrpXX?=
 =?us-ascii?Q?uhXKXk9X7f0OdcK2YGN/GcBphsDaYBjh+gmvHsjs+4/stE9tfj7GGhu4nDzo?=
 =?us-ascii?Q?P1bNotpxbBQr9UfyzB0+miyCmYPUqb9sn/JSE5wjDxY4wf9raF7xX+H/RA51?=
 =?us-ascii?Q?QGYNIJNGID562cyRKFw8XVVRfpE0wqsOLENfbpXdxX1xPqdgvWFeGwD9NZhV?=
 =?us-ascii?Q?FgGdLXAhvUheqROSvJKtN3ZL5qBies7RSoE5XPByGKQdq+bKTYje9htfk9yu?=
 =?us-ascii?Q?eiECO0duqttsSwNiAtcwKFKHXKaO958T+IIK01EOc+OZKYcxEnYAWUVb9qCg?=
 =?us-ascii?Q?AfH82aG+7pNgCdSVg/FVilG7EbJOJ+88ePN9QpGA5utO+2lZgmsMT8rLsjWQ?=
 =?us-ascii?Q?UOYtor6HAAVp83fRh0C11VtEIMJsNqyVnmXJHy162cuyItuKqlEpeYOk6fGq?=
 =?us-ascii?Q?ON2aGCTnUrwh7X/dmcDYlD4NMQfdwGO3DgSmrkx3tqHqcAVjpLo8OmpApU4N?=
 =?us-ascii?Q?dgxfB2tnMxDOckr5hwvqGyQshQTiSoTWM3LgF4l1uG1tPqe8cvyiCpjYQcVb?=
 =?us-ascii?Q?0+TWfADSDKThTyhZDY/jHzfIUb4aEX0xRowuqi6HggN/OciOqGTgsM726mT4?=
 =?us-ascii?Q?sMsBTKV/x6ZNyOYAm9U=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR12MB6486.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(7416014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?/CYglk0LsikG8hlV1F2MPz6VjUl/ZWf2VLz7uD89RMl8E6EXpDLmYrvRUCLK?=
 =?us-ascii?Q?b/zJoQFpajfy75ZGvvYhV8Bhx3gZNsMPJ5Ofu9omASXB/Y96d5iaVdYRHOyI?=
 =?us-ascii?Q?stJ/1BVJ0GMZU14GEaBHYEKU3tUCQnRIBf2KunQMwixRDK3cUqZfypEH0XRV?=
 =?us-ascii?Q?4oaeMODIOA58DQsHs8NsZodnkMN5Esq7noc99PihNLSQvtfgRBM8a4s+s4CD?=
 =?us-ascii?Q?46r5n+FGPKw176zWnQ4AcrGFIzd+4/jyOXrp2Z6zl4rFoozOBS/XDIY0Ey+E?=
 =?us-ascii?Q?wI99H4NoXkMa7RlftM69mH2ThfShkLd7VzSx4VKci0aViGj7MTlp9PkCx+lF?=
 =?us-ascii?Q?hbRgfp6sWnQLFkCCgZXupF829EGlk6uGHsDMWTOKT8E3qcPcht9UenfTz1Xi?=
 =?us-ascii?Q?E4+QzXnibc1FOXrgMLX1pIFACumTCEOXqysI0q/lPzfExi9+Rd2MOl2Naqra?=
 =?us-ascii?Q?1ePs1b4oM29Gs4/or3p91eg8rj60mYjEdlkDfLvxvpHT+1qBnnJOwnVmCSf+?=
 =?us-ascii?Q?vf1EOalavyIrLmZVnV5clg+aioj65iNUHhaWoLRJewuFfAOKvakYCgvPiaTa?=
 =?us-ascii?Q?Yc8Eonom+Vbnf0bh9yufjlyq4RTI23/C4WIAnYB0XipL2I//tJUT3lN2xtYg?=
 =?us-ascii?Q?JMy7H8fMwO8jkvRkfgx/jGpx5fzsBbJFD/cKM1aaNvyIZimDehUqbo7JeDA3?=
 =?us-ascii?Q?s16ebYtU6D+zO6i9QlzwjME0gy9DHgfzlve4lb8IC1cqILW8jX0izGHgfZ5R?=
 =?us-ascii?Q?STY46qoPlGRrVGNOKw+tDnPtUv2z2fjBjNaKLD4elJvElnEHWpVF1M/Kjm+3?=
 =?us-ascii?Q?Lt0p2hgDpchdxWDY+Jup4oPA2hc0QXSCrYVe/VSQaqDr8Q4Ia3GUO02wNs69?=
 =?us-ascii?Q?9LMFIwfXdSyEBz/LJv3tOP0Q1EsugkSjNPLrCc8v/8yb6ZyTziHSII9Opi9M?=
 =?us-ascii?Q?q+UwFg0uBrhwWULeh/uqeOS6ThFswZAvz5X/lA8LKQykcWy6s7BXrv8sBw98?=
 =?us-ascii?Q?F9zctPYFrAhUFMLIB7np5m1Ig46TFo605xvrJiOEU4+3sLlODzwkeGjEGZh7?=
 =?us-ascii?Q?5uBEa+NTsMyCyRXBCA5po/OF46wdF9uR21cmPZ1Y/Sfa/QZxOdsU2zkMjYuX?=
 =?us-ascii?Q?WE51PEedKdX19FiF7bHx85i7yHMAbS/lASX4c5QcibikhvyCOfHdU17NzLmh?=
 =?us-ascii?Q?TtQHfQHQZqsCuUJTjNL3ogbWHzvwLl6OeVjw9WMYdm18suqxXK5tKWgX5dNU?=
 =?us-ascii?Q?JwmHCJFPvVdQc5wrOQcWb6aAU25Lp4EWAqfLuOMJrunzG0Fz9AkkU8emQCTd?=
 =?us-ascii?Q?i3csa83NlSgj2QYl9hK0x5yGSOADOR+VqNRNZtEPQ8duo7RokbAU+NU8XhW0?=
 =?us-ascii?Q?ebL370IVTb+XsKdiKVWumN0SG3Bc4Dw3LjSzvjR6OzNiaLRkvArbn3Lmsgqh?=
 =?us-ascii?Q?/WGIdkpbgupLRDmu+H+ORhQPCqjQ9lgd5/O6L/bYcqZhZlXQl9vsuD3101n3?=
 =?us-ascii?Q?fAUOf3yYmtEVV91eD82leiQs+V8JTPlQcnJ3PFnZ7hsAwJBJy2pRf0Q+yb82?=
 =?us-ascii?Q?OuHICBps5hKKtB0lMPWENYyF4Mg8wC8C5TnxvMkLSWQlbvv76uoHlugW0O83?=
 =?us-ascii?Q?r3PUZcQMN0kVpALlA1oQN0O/6Bq9p74n4ny3r5KNxxLUMeOBx+e/EiG0NgDk?=
 =?us-ascii?Q?RqnhAPgL4lDe8HVExO3rlcOtDTe8KnI/L/Ret/q8ROuxQWql6BfTF/LSxVpO?=
 =?us-ascii?Q?UMvtopIimg=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d8e5a34c-df46-4119-fd68-08de5bb44130
X-MS-Exchange-CrossTenant-AuthSource: DS0PR12MB6486.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Jan 2026 01:51:28.0629
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: a7wQD5e1GYtLKJKhbDzPS98WFwAj8rY9Wexjq8o44Z9J7SwOUg7I+HyyIXh4LAcq5Pfz9oZd9mcnmC88enhGnw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR12MB5630

On Wed, Jan 21, 2026 at 08:36:05PM +0000, Gary Guo wrote:
>>> Why is this callback necessary? The user can just create the list head and
>>> then reference it later? I don't see what this specifically gains over just
>>> doing
>>> 
>>>     fn new() -> impl PinInit<Self>;
>>> 
>>> and have user-side
>>> 
>>>     list <- CListHead::new(),
>>>     _: {
>>>         do_want_ever(&list)
>>>     }
>>
>> The list initialization can fail, see the GPU buddy patch:
>>
>>         // Create pin-initializer that initializes list and allocates blocks.
>>         let init = try_pin_init!(AllocatedBlocks {
>>             list <- CListHead::try_init(|list| {
>>                 // Lock while allocating to serialize with concurrent frees.
>>                 let guard = buddy_arc.lock();
>>
>>                 // SAFETY: guard provides exclusive access, list is initialized.
>>                 to_result(unsafe {
>>                     bindings::gpu_buddy_alloc_blocks(
>>                         guard.as_raw(),
>>                         params.start_range_address,
>>                         params.end_range_address,
>>                         params.size_bytes,
>>                         params.min_block_size_bytes,
>>                         list.as_raw(),
>>                         params.buddy_flags.as_raw(),
>>                     )
>>                 })
>>             }),
>>             buddy: Arc::clone(&buddy_arc),
>>             flags: params.buddy_flags,
>>         });
> 
> The list initialization doesn't fail? It's the subsequent action you did that
> failed.
> 
> You can put failing things in the `_: { ... }` block too.

This worked out well, thanks for the suggestion! I've updated the code
to use `CListHead::new()` with the failable allocation in a `_: { ... }` block:

        let init = try_pin_init!(AllocatedBlocks {
            buddy: Arc::clone(&buddy_arc),
            list <- CListHead::new(),
            flags: params.buddy_flags,
            _: {
                // Lock while allocating to serialize with concurrent frees.
                let guard = buddy.lock();

                // SAFETY: `guard` provides exclusive access to the buddy allocator.
                to_result(unsafe {
                    bindings::gpu_buddy_alloc_blocks(
                        guard.as_raw(),
                        params.start_range_address,
                        params.end_range_address,
                        params.size_bytes,
                        params.min_block_size_bytes,
                        list.as_raw(),
                        params.buddy_flags.as_raw(),
                    )
                })?
            }
        });

I'll remove the try_init() method from CListHead since new() is sufficient.

-- 
Joel Fernandes

