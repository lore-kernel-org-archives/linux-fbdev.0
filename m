Received: from SN4PR2101CU001.outbound.protection.outlook.com (mail-southcentralusazon11012013.outbound.protection.outlook.com [40.93.195.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 76E1E47278B;
	Tue, 20 Jan 2026 20:44:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.195.13
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768941888; cv=fail; b=cvVriXY//FR8M0ZuDzh8hk49h6s/AHJdnTETZNxb7aq9b5JjlGEZuNKp6ytwXbD9XUSXiGgtmE8YFQmkr9joJMc3G5X/sSD7j6ndxuG1FbUr3J4rnIGSze2YfRsppHbwrF6nJNCs1YfzAd58yfR/ISxEXAKz/CNv2rnbqSWzHhw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768941888; c=relaxed/simple;
	bh=6Safx74B/kEGIcvnSdeFI/PcH8Wo+4OmVJ/f6QPsIOQ=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=Fq8ynpZmrW02NiljY+m1qhLOasa+dlETuisLCzylrAaCuomQA2SPmvir71+OhTD1BX9e8wBMh4+vPj4wujWyUJAKZG5058LQG4JM90Sn7oGQyvsGoB59SwbDUCZajzDRsgSuasbrO4KLx/rCvDtIAbnJgWFHG/h6QU46bvzwGXU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=BM2M06c5; arc=fail smtp.client-ip=40.93.195.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="BM2M06c5"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=nKAJKyDiAwR/28ewkIMF7n13R/76ZDXjMdNY6ygHo0Ln9qgZxwZQHQMYNuho6khmP9vhc3igJfdUoYfP7HUyM2KgShmHAwdYDEMPtCNwd1Ma8wkVhruI4XhIjhxo+ITJ7yDGLguKmWpFXpm6XaFtB9/RSbSNTYhhLudnCY1En8bNn66TkStI73mxKQah8pXfZ4ffoYHt2Z/UirrA+5sflLY7lYb2GQEYYFDgPxICcKSTmSwJcLZwLebNLSHuksxw4WCY4+LSnM9/yEWyRyYH4TOowFKkldCBPIz6RpfQC5Hsr1UkkjQ7MuTlmruywyBImA4vl8F6+uwm3TZEVyAv7g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0RMtF/D8S5J5kI93dJVCqOe3D5PszbnpUv1akdnavMY=;
 b=YzN9fkkptoE+1X7Zfal1ENt4eM4uBehcuUswgUR5xkPJOjC8+SWJugKELsL2RFv0TBVzP1TCok3hhZykQ0gMNlMnG0jrm70+mN0qTU7hYJsLLbJ7nMwr3HqsvPk7rM0K2JuSOYMSefPficoB2A+qk+cOcByB31lLlOWupweOGw9m94q1qxQHD5OEbASXsfLLTNNak+xnEc+8/PXrANGdBdmQJSYjJhUPjIiMNMeeP+LZ1g7ivBPtDi0OPgdnCpx6pv/hhA3sQVa08u6voED/3b9JYppZb/0T2ENzKlGpout7NotGX+ceJ+p5z3LB5zx6AUhBSCOECI1VVPYx+3iCyQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0RMtF/D8S5J5kI93dJVCqOe3D5PszbnpUv1akdnavMY=;
 b=BM2M06c5C6nUzDXHGpHjoqUGoCfYQdguwHojOnKhipv2tXg3hlBNuoov5JE0lS1AFo56DLHDnC1R4VTsHlxdmCeLt3z2ylew/2kfICrceDvC9f7h+9Q7TK0wPMSqz3fvsu5beXWpocqf6+sBDsBL1dMEEvjsmcniSKMGhoCYiTI/8StwVLDhwWFUipQAojDid4gGP1fCm6YQNPqS8D7C/aqobbrL+VuSAyM/zsfBlanoZO3+CnaH7D6fuNleq1bUx85GmXaKi/THpvDvxHT1fweupQVKU2Su7tJq25XXCZfwF5sP2eie0BCV/3jMLo138pv6/PNo/3g/R/DWiLrjiQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DS0PR12MB6486.namprd12.prod.outlook.com (2603:10b6:8:c5::21) by
 CY1PR12MB9651.namprd12.prod.outlook.com (2603:10b6:930:104::8) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9520.13; Tue, 20 Jan 2026 20:44:30 +0000
Received: from DS0PR12MB6486.namprd12.prod.outlook.com
 ([fe80::88a9:f314:c95f:8b33]) by DS0PR12MB6486.namprd12.prod.outlook.com
 ([fe80::88a9:f314:c95f:8b33%4]) with mapi id 15.20.9542.008; Tue, 20 Jan 2026
 20:44:30 +0000
From: Joel Fernandes <joelagnelf@nvidia.com>
To: linux-kernel@vger.kernel.org
Cc: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Maxime Ripard <mripard@kernel.org>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	David Airlie <airlied@gmail.com>,
	Simona Vetter <simona@ffwll.ch>,
	Jonathan Corbet <corbet@lwn.net>,
	Alex Deucher <alexander.deucher@amd.com>,
	=?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
	Jani Nikula <jani.nikula@linux.intel.com>,
	Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
	Rodrigo Vivi <rodrigo.vivi@intel.com>,
	Tvrtko Ursulin <tursulin@ursulin.net>,
	Huang Rui <ray.huang@amd.com>,
	Matthew Auld <matthew.auld@intel.com>,
	Matthew Brost <matthew.brost@intel.com>,
	Lucas De Marchi <lucas.demarchi@intel.com>,
	=?UTF-8?q?Thomas=20Hellstr=C3=B6m?= <thomas.hellstrom@linux.intel.com>,
	Helge Deller <deller@gmx.de>,
	Danilo Krummrich <dakr@kernel.org>,
	Alice Ryhl <aliceryhl@google.com>,
	Miguel Ojeda <ojeda@kernel.org>,
	Alex Gaynor <alex.gaynor@gmail.com>,
	Boqun Feng <boqun.feng@gmail.com>,
	Gary Guo <gary@garyguo.net>,
	=?UTF-8?q?Bj=C3=B6rn=20Roy=20Baron?= <bjorn3_gh@protonmail.com>,
	Benno Lossin <lossin@kernel.org>,
	Andreas Hindborg <a.hindborg@kernel.org>,
	Trevor Gross <tmgross@umich.edu>,
	John Hubbard <jhubbard@nvidia.com>,
	Alistair Popple <apopple@nvidia.com>,
	Timur Tabi <ttabi@nvidia.com>,
	Edwin Peer <epeer@nvidia.com>,
	Alexandre Courbot <acourbot@nvidia.com>,
	Andrea Righi <arighi@nvidia.com>,
	Andy Ritger <aritger@nvidia.com>,
	Zhi Wang <zhiw@nvidia.com>,
	Alexey Ivanov <alexeyi@nvidia.com>,
	Balbir Singh <balbirs@nvidia.com>,
	Philipp Stanner <phasta@kernel.org>,
	Elle Rhumsaa <elle@weathered-steel.dev>,
	Daniel Almeida <daniel.almeida@collabora.com>,
	joel@joelfernandes.org,
	nouveau@lists.freedesktop.org,
	dri-devel@lists.freedesktop.org,
	rust-for-linux@vger.kernel.org,
	linux-doc@vger.kernel.org,
	amd-gfx@lists.freedesktop.org,
	intel-gfx@lists.freedesktop.org,
	intel-xe@lists.freedesktop.org,
	linux-fbdev@vger.kernel.org,
	Joel Fernandes <joelagnelf@nvidia.com>
Subject: [PATCH RFC v6 23/26] nova-core: gsp: Extract usable FB region from GSP
Date: Tue, 20 Jan 2026 15:43:00 -0500
Message-Id: <20260120204303.3229303-24-joelagnelf@nvidia.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260120204303.3229303-1-joelagnelf@nvidia.com>
References: <20260120204303.3229303-1-joelagnelf@nvidia.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BL1PR13CA0110.namprd13.prod.outlook.com
 (2603:10b6:208:2b9::25) To DS0PR12MB6486.namprd12.prod.outlook.com
 (2603:10b6:8:c5::21)
Precedence: bulk
X-Mailing-List: linux-fbdev@vger.kernel.org
List-Id: <linux-fbdev.vger.kernel.org>
List-Subscribe: <mailto:linux-fbdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fbdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR12MB6486:EE_|CY1PR12MB9651:EE_
X-MS-Office365-Filtering-Correlation-Id: a07fc773-eecf-4720-8462-08de5864b5b4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|7416014|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?2WVAjT5b5JwYmCHy00N8I4jLxMX1ohh8uFMk87RzE2FaqLjGVACAi/W2/8Z0?=
 =?us-ascii?Q?Vm0KwD5vT8Cdu9DiF92wYHC7G9zaoOd2iacFdh+Sh+0/jFBpihJTRLHRpGH9?=
 =?us-ascii?Q?wXivQomKWOSJGNrY90UvSAzPxSQpLBUg040v/YlR28ddjtVKMfOtEVEy7olR?=
 =?us-ascii?Q?Zks83dkP76XoXBh3HiRNJqED218f367MgNXGIh2GOzp8E+es02q0AvG3l/Pc?=
 =?us-ascii?Q?/jtrHhrR28AwONYLzNGYwW03tplQBtNW39ivVrI9gIMYmp5bH2Oz8pzaiXzb?=
 =?us-ascii?Q?dFEHI2IMMDS+nH0k1W3/54vxB8rwSYwip+FwCveB4gub1REHBe6BlZjW6Tnl?=
 =?us-ascii?Q?BdJ19hKnBAA7rT8nJjaFXdTAMc1/n+mfph4ywRwIYgjOa9yeAifgl+o4D4JN?=
 =?us-ascii?Q?vVwtMO0QKlRBFjh7G1Lz2LDOq0wPBuj5ghj4J5cu0J+O4bJegeMJI5v7i2Wp?=
 =?us-ascii?Q?lEJukFyUGSXWs+DIc2EpdcYYTUNToJmX3oO0p53P/KsT/Mcx4W6XqJOfy685?=
 =?us-ascii?Q?iga7lADyI8Z/nyc6LuNUWSk1jsdosO/B9Noe/Xv57kKxEhiFr//QpKkWeekA?=
 =?us-ascii?Q?mGbGl/vk03nxfzFm/LAi6t7OPPmJMHKt/eJ/imWcHpiDplUYMDYqM7R7yRN8?=
 =?us-ascii?Q?cMTKSrlZm3ZMmeFAfUvtb9xnrltTxQgN+jAcoj48aNGPJCtJaX+hgdx7Uqyd?=
 =?us-ascii?Q?lP3cmJOxhe9jQ6/rjep2MEUmzEEXvfeo/HSCRCC1YKKtibvV+EOe2jZSAzch?=
 =?us-ascii?Q?P5XNJ3pFRV5ZaFYENMaqiuLBoEYATqzpoyFaK5DzGtsfBZoK0NAxJwDQrd1T?=
 =?us-ascii?Q?TP9xdAfWNNA9ViUvq8YfSnYRqp+Uc358eNBIgED/nokN/naM16Y/2aiqEn25?=
 =?us-ascii?Q?6otIa4aVmHD/bB6gaSakt9QJF4Yn6OdYWzd63cltzDBoQncLZX4FsrJeF25J?=
 =?us-ascii?Q?CIt5sllqWgaaSwM/0wNbzjyYrHly9Jg/dZCi2TPRvCM9Nx7Sh302geCWyY4P?=
 =?us-ascii?Q?6OR1ZdUo56kOh3TQ1Zxtj25s/dPCRAfa0Kyav+iR3MUeXfSk/fFR/7cUQLdB?=
 =?us-ascii?Q?sFkTHp2ik4J1khqGxaorMZn9QN2YGwsUkYIbH5L+CKh/MqOlc9rg7dr+V/Cq?=
 =?us-ascii?Q?h1le/LSCA5GQPUbuSTRuELLL+vukGl0garDq40lEm2rIlrjpBCJjkSSa03RZ?=
 =?us-ascii?Q?svkdjEAt4gqp28HTkX9531vu99J2RylrhgAPF1pibCgaH+xkhtzItPYxBSRe?=
 =?us-ascii?Q?TEO/TAf4+0GDrwSn3UnHtkoTMdaoCM9gi/iQn83yhHW06vU6L2Bt8IBZXW6C?=
 =?us-ascii?Q?KvK3oxkXyd4e7rxc1xDMCw1A1v3uMeNFHF5Qp9W1E9ftORZ9MdewGeypQJyN?=
 =?us-ascii?Q?nwVnFgY8aS8YHRjU7XW6sK4lA2FqtHArMY9Dr06U/KxWbqCZ8N6Hbn50HZ6K?=
 =?us-ascii?Q?KbyiMU6CYK4StD5DPSI7quZjoC/ccUiw/jkA55mXLmyHgtHY5m3OS8OIlQBu?=
 =?us-ascii?Q?vmu6gZsfRjlXAYDCCHdAGjCGGaadwzR4qApHyMx3tXFasy1kGDMMeUrSDrfs?=
 =?us-ascii?Q?ExMzCEhxFSgDN8EMaFc=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR12MB6486.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(7416014)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?jDMAoKRUXDUG4g8R89XQKTeuQveTmrWsyEFKRPRET+qGdBfuUdxwYvchCI21?=
 =?us-ascii?Q?xpW+EzswzGGHvTLCBKjeodeoXSZlsxkdraOPL8UpOeuwnGmZKxQlFEzpit1b?=
 =?us-ascii?Q?arZxL9d9kln/VJ6CSGiA1/I1P4OHuMN38xqrPjQiA4HYYhgf6m7K2TFCucXp?=
 =?us-ascii?Q?/wjiQwkwjY9ONMneXlX4egaMALGRvIQX6d6+gn00jP5+2kYrXMZkK6DslvIw?=
 =?us-ascii?Q?PQby7zuHofxhYKgM1hBt4usVXBWuADgXq2Hfn//0GznCx3fjOykAwzIKLdoS?=
 =?us-ascii?Q?heeivtVdTumGdtUGLjz6JMAwvfyTzX+vXtLgD0bC6bIO+9rQFOixIJyHGXB1?=
 =?us-ascii?Q?skg3CuxzYqTxDPzp/hxS1FqiCE6/JvZUauXEdeV9Y1hQQvXtRwAd3xaJeSDJ?=
 =?us-ascii?Q?a9257Ybog0XyDcM0QkzfS16ETXKMR1iLSx4A7ZUUIvMg0iOgmoP5iv4ArLJI?=
 =?us-ascii?Q?HwvmiBNHdTLGisFDXeBmQm2TM/6DIWDrUsk4ZGcor16TlStZMmCHznCSAyHI?=
 =?us-ascii?Q?B4FxDgCS6L1uPlXeNsYdzCZdm6dUOpQDDLdVQKjNxwKjyXtMrmdHbAGrS89C?=
 =?us-ascii?Q?eBsUg/k9M0Rm/kjMW3mJUxy4/wGMTV1uzCualk4fm83394R+CZbVOmJYzMZx?=
 =?us-ascii?Q?iQsCZcQLL88YQ7d/Fj9r+mHfJXpzfzR0uzxGUmxDMIMcOIAUsgD1hHK0bkMW?=
 =?us-ascii?Q?1lhKtAFqsYq9/0hweK0AWYNdS1rB00GBgxTV7XJE+QcWkJB0fTapVcxLBI9I?=
 =?us-ascii?Q?CMGjHAO4w6f2eA0UNfQ16Ho9a1gZZyV5qqwPEs4DjMXdHElrtj9P34ZG5Pji?=
 =?us-ascii?Q?mjWwdxagB3ISgmk5zG/qFxE5ipPG52nfrfztOgpnJKFL52L1u+WyvvyvUdT1?=
 =?us-ascii?Q?Xm5jO/HUb+FV9aqsfNC3DlEvorP4rVmHcXqMeBH5MmXMaskrkYWvggypsiUj?=
 =?us-ascii?Q?UUVo/qhi0YWQZlGF94Boc6h9pw29qIuqgKUDSXjEoRERmnAzxv9RmMq8mPn+?=
 =?us-ascii?Q?OGlni7TBElaYaOa7HB2ftLW3OWjX9heuLifoRtg5sruCdsoJBzqHPmsBKtNB?=
 =?us-ascii?Q?ARTxWh5grsh7PiPPvdie7peknyKq4hhiEPraSvOgIxhE2viL/iUW1kVuvl/2?=
 =?us-ascii?Q?7FVsJZCIsqvu+vhAMPrimXzbjEatc6fM5HFMgoVJvk3ZaFrEaB3Bw9r762RR?=
 =?us-ascii?Q?lG+AT7y9UfK61gNc258hZ7CeK9D5lmd4qXJ245mgFCKiW+DEC6yaRTd523Rm?=
 =?us-ascii?Q?egBxoHLW0WqrMxmM4q/eduPtxuI7htHYGNzppSDJV4kUGOGP8h/zr82GrYGD?=
 =?us-ascii?Q?CUV8vkolQXNOkLIs+NX/TDPUt3fO89OmwAzJZErrJ7CRp9/3Z9m0C7+nMfwo?=
 =?us-ascii?Q?bALqjbE5qLYWx/+LuxoUWReN02DZdolWXuUK/2kvwfgOa8BR8sgmUCybB6I+?=
 =?us-ascii?Q?O0tqOYY4BC5j6zsyQfnJhfGjZGPGKnkDdwjJGEygWRpuuk0vskmV5t425eiq?=
 =?us-ascii?Q?KDk+WgiZVvL0dbUOuLYTgn5Mdw7QEjPObIBDvMNQCrPe+vUfR+SVVN9M+GTY?=
 =?us-ascii?Q?yCyaEQsKGRjCb56ImopoI5dDW9OYa79kg5YyeG3wi7YK3kol+d/Lp3Wu5/j9?=
 =?us-ascii?Q?y0TYzCU18BsIyp77k0f4cy2NJiVc2fhXyilu/baoXQbmzAHpxqjeS1bdeUtK?=
 =?us-ascii?Q?NvCO+uYk6G58SJactVEcbCIxWw9WKxfJS3RVbjLxcQY+2fRhzrTq7M0ZaZVA?=
 =?us-ascii?Q?6KJEFqwEXQ=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a07fc773-eecf-4720-8462-08de5864b5b4
X-MS-Exchange-CrossTenant-AuthSource: DS0PR12MB6486.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Jan 2026 20:44:30.5398
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: YiLIInnqRe+b7FzP0824dA8EkyeXk2RtO1PmelwtytUxP6qqievOSs8X6ZHwVHCilaR333WEHTw9SZibOedr3A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY1PR12MB9651

Add first_usable_fb_region() to GspStaticConfigInfo to extract the first
usable FB region from GSP's fbRegionInfoParams. Usable regions are those
that are not reserved or protected.

The extracted region is stored in GetGspStaticInfoReply and exposed via
usable_fb_region() API for use by the memory subsystem.

Signed-off-by: Joel Fernandes <joelagnelf@nvidia.com>
---
 drivers/gpu/nova-core/gsp/commands.rs    | 13 +++++++++-
 drivers/gpu/nova-core/gsp/fw/commands.rs | 30 ++++++++++++++++++++++++
 2 files changed, 42 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/nova-core/gsp/commands.rs b/drivers/gpu/nova-core/gsp/commands.rs
index 311f65f8367b..d619cf294b9c 100644
--- a/drivers/gpu/nova-core/gsp/commands.rs
+++ b/drivers/gpu/nova-core/gsp/commands.rs
@@ -186,10 +186,13 @@ fn init(&self) -> impl Init<Self::Command, Self::InitError> {
     }
 }
 
-/// The reply from the GSP to the [`GetGspInfo`] command.
+/// The reply from the GSP to the [`GetGspStaticInfo`] command.
 pub(crate) struct GetGspStaticInfoReply {
     gpu_name: [u8; 64],
     bar1_pde_base: u64,
+    /// First usable FB region (base, size) for memory allocation.
+    #[expect(dead_code)]
+    usable_fb_region: Option<(u64, u64)>,
 }
 
 impl MessageFromGsp for GetGspStaticInfoReply {
@@ -204,6 +207,7 @@ fn read(
         Ok(GetGspStaticInfoReply {
             gpu_name: msg.gpu_name_str(),
             bar1_pde_base: msg.bar1_pde_base(),
+            usable_fb_region: msg.first_usable_fb_region(),
         })
     }
 }
@@ -235,6 +239,13 @@ pub(crate) fn gpu_name(&self) -> core::result::Result<&str, GpuNameError> {
     pub(crate) fn bar1_pde_base(&self) -> u64 {
         self.bar1_pde_base
     }
+
+    /// Returns the usable FB region (base, size) for driver allocation which is
+    /// already retrieved from the GSP.
+    #[expect(dead_code)]
+    pub(crate) fn usable_fb_region(&self) -> Option<(u64, u64)> {
+        self.usable_fb_region
+    }
 }
 
 /// Send the [`GetGspInfo`] command and awaits for its reply.
diff --git a/drivers/gpu/nova-core/gsp/fw/commands.rs b/drivers/gpu/nova-core/gsp/fw/commands.rs
index f069f4092911..cc1cf4bd52ea 100644
--- a/drivers/gpu/nova-core/gsp/fw/commands.rs
+++ b/drivers/gpu/nova-core/gsp/fw/commands.rs
@@ -122,6 +122,36 @@ impl GspStaticConfigInfo {
     pub(crate) fn bar1_pde_base(&self) -> u64 {
         self.0.bar1PdeBase
     }
+
+    /// Extract the first usable FB region from GSP firmware data.
+    ///
+    /// Returns the first region suitable for driver memory allocation as a base,size tuple.
+    /// Usable regions are those that:
+    /// - Are not reserved for firmware internal use.
+    /// - Are not protected (hardware-enforced access restrictions).
+    /// - Support compression (can use GPU memory compression for bandwidth).
+    /// - Support ISO (isochronous memory for display requiring guaranteed bandwidth).
+    pub(crate) fn first_usable_fb_region(&self) -> Option<(u64, u64)> {
+        let fb_info = &self.0.fbRegionInfoParams;
+        for i in 0..fb_info.numFBRegions as usize {
+            if let Some(reg) = fb_info.fbRegion.get(i) {
+                // Skip malformed regions where limit < base.
+                if reg.limit < reg.base {
+                    continue;
+                }
+                // Filter: not reserved, not protected, supports compression and ISO.
+                if reg.reserved == 0
+                    && reg.bProtected == 0
+                    && reg.supportCompressed != 0
+                    && reg.supportISO != 0
+                {
+                    let size = reg.limit - reg.base + 1;
+                    return Some((reg.base, size));
+                }
+            }
+        }
+        None
+    }
 }
 
 // SAFETY: Padding is explicit and will not contain uninitialized data.
-- 
2.34.1

