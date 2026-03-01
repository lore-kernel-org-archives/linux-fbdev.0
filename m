Received: from PH7PR06CU001.outbound.protection.outlook.com (mail-westus3azon11010028.outbound.protection.outlook.com [52.101.201.28])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C295731AF1B;
	Sun,  1 Mar 2026 12:40:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.201.28
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772368838; cv=fail; b=jdgdj6cpi5yyfwLweLbkj5q34p74ljBU80CWc/yOv+J08E1NF+7OF6Felw30AQI/gXImBRX3X519/Eutr4AiWCqqCuCD0ZjuMlNkS6pA04/eJTebnYsK3w1CVTy5rxAtWb01PXXXClh4vpFD56xPjtYh5P8IJP7Z+y+lMxjBSeE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772368838; c=relaxed/simple;
	bh=mkubTGHEOYsYXNU3J0wvuuyR0SZyd2eB9ToiavWdmPw=;
	h=Content-Type:Date:Message-Id:To:Cc:Subject:From:References:
	 In-Reply-To:MIME-Version; b=TWkMgYXeK/0B3DvifryrPZfDjGHjwzIgaGcG0m7tKtuXn5l+rO+3wBXC+W2xOm9E1GqmcS0cybT/Ir+uYI4opz08UGvW9dx5ti4N/Rx1N/8H25/O08N1+COGPItx1IGGlGV6AHSNtKnYHCCpHxIeZMv3ExUoHJd5jL6W5RePxjg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=rE1g9gwA; arc=fail smtp.client-ip=52.101.201.28
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="rE1g9gwA"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=egpiKKfGJqn1T6QA0bBemooxRYO+NBFkRdHmTvYOBVQkx9AXqp8gvt6kU4uB/ADBlZQYzXTSK5WHYCnEcYBbEihRp+y7FlFiEa/cGhyfF0Ooz9Iteijb5uzXtkY79IUGlpNecmjR/oOBEMCQUZPyKWGenw0eiT89rJYfLzQumG4UwYrwxazB58ZpiervYeFDA1z/2OI4ojl1HFmpACEhIs+G8FFgDlbdTBmhcgTXkKGPOd9UIPmhG2s7Yu6P6BP0sOXYzEwLVweJxrA+4UBZZhrDghwsuBVIT1/OZSXBawzNo4Blv4K6Gt/GLPSyn01V7k3Tw+Cc2J7Ckr0LLl46UQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mkubTGHEOYsYXNU3J0wvuuyR0SZyd2eB9ToiavWdmPw=;
 b=Nvd5IsiEbA73tRvwWECCG53ezGbJM3fmtNxuE9CU2Hg/7XQ4XL2v16Bg5Ifv87/1IzTqeSXNxrOVFoibxlzTDEXRCl+YZEgI94Igpym7vwP5ysydMsyAWVXS5ij6XKlM2GBbE/eZ7dUTsHUvhU4ZwaH7v8KtjbEOUExRW/KkafAQlNpqXRyXSAjGF+dUDWaEQ9n4tJr+QbpyjLzmmf85xIOt5JHxlgE1OPvO0pNl0mlndbIGavGNLcg4v4Q/yPavp1CEj7Sd6mrcbGwoxWrhI1dUzMA8OwKudtlJH8/O23KMQvYrZa/RbJPc8IOfJ3UcB7TX+sqbbkJtvNZoHfvdCQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mkubTGHEOYsYXNU3J0wvuuyR0SZyd2eB9ToiavWdmPw=;
 b=rE1g9gwAPgwTDJMRneU68ct1LwfAbT4hJfmdEmtpomHwGsFm4KBSANOQoOKSpqS5rc0cUfba+uaok6EZ08998jXIo8WoHeEyTu66JISMkvb7XVo4kplfxIuDsM/eMlJMU8xDcD6tEMKMnLimrRGcTjBPE2d/rADRr/7v/FJcByMwNWkQoiJt7FX1MHTezvqvPnprb4Jr8/gjGovCd6CMog76vg/YmbNQ7UyAYqv6DZz4sGK24cwAQCG1JWgZglIiwCIKg4RQ84Apjjqz4pNKMXE0KC0WhQOaMO5GHVxwnVwyNwdBoaeTElgdukqpLoX/93Xcotoj61RyWDm812s1xA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CH2PR12MB3990.namprd12.prod.outlook.com (2603:10b6:610:28::18)
 by LV2PR12MB999097.namprd12.prod.outlook.com (2603:10b6:408:353::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9654.11; Sun, 1 Mar
 2026 12:40:33 +0000
Received: from CH2PR12MB3990.namprd12.prod.outlook.com
 ([fe80::7de1:4fe5:8ead:5989]) by CH2PR12MB3990.namprd12.prod.outlook.com
 ([fe80::7de1:4fe5:8ead:5989%6]) with mapi id 15.20.9654.020; Sun, 1 Mar 2026
 12:40:33 +0000
Content-Type: text/plain; charset=UTF-8
Date: Sun, 01 Mar 2026 21:40:28 +0900
Message-Id: <DGRGBBL27J33.3RR6IRBXLYQVG@nvidia.com>
To: "Joel Fernandes" <joelagnelf@nvidia.com>
Cc: <linux-kernel@vger.kernel.org>, "Miguel Ojeda" <ojeda@kernel.org>,
 "Boqun Feng" <boqun@kernel.org>, "Gary Guo" <gary@garyguo.net>,
 =?utf-8?q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, "Benno Lossin"
 <lossin@kernel.org>, "Andreas Hindborg" <a.hindborg@kernel.org>, "Alice
 Ryhl" <aliceryhl@google.com>, "Trevor Gross" <tmgross@umich.edu>, "Danilo
 Krummrich" <dakr@kernel.org>, "Dave Airlie" <airlied@redhat.com>, "Daniel
 Almeida" <daniel.almeida@collabora.com>, "Koen Koning"
 <koen.koning@linux.intel.com>, <dri-devel@lists.freedesktop.org>,
 <nouveau@lists.freedesktop.org>, <rust-for-linux@vger.kernel.org>, "Nikola
 Djukic" <ndjukic@nvidia.com>, "Maarten Lankhorst"
 <maarten.lankhorst@linux.intel.com>, "Maxime Ripard" <mripard@kernel.org>,
 "Simona Vetter" <simona@ffwll.ch>, "Jonathan Corbet" <corbet@lwn.net>,
 "Alex Deucher" <alexander.deucher@amd.com>,
 =?utf-8?q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>, "Jani Nikula"
 <jani.nikula@linux.intel.com>, "Joonas Lahtinen"
 <joonas.lahtinen@linux.intel.com>, "Rodrigo Vivi" <rodrigo.vivi@intel.com>,
 "Tvrtko Ursulin" <tursulin@ursulin.net>, "Huang Rui" <ray.huang@amd.com>,
 "Matthew Auld" <matthew.auld@intel.com>, "Matthew Brost"
 <matthew.brost@intel.com>, "Lucas De Marchi" <lucas.demarchi@intel.com>,
 =?utf-8?q?Thomas_Hellstr=C3=B6m?= <thomas.hellstrom@linux.intel.com>,
 "Helge Deller" <deller@gmx.de>, "Alex Gaynor" <alex.gaynor@gmail.com>,
 "Boqun Feng" <boqun.feng@gmail.com>, "Alistair Popple"
 <apopple@nvidia.com>, "Andrea Righi" <arighi@nvidia.com>, "Zhi Wang"
 <zhiw@nvidia.com>, "Philipp Stanner" <phasta@kernel.org>, "Elle Rhumsaa"
 <elle@weathered-steel.dev>, <alexeyi@nvidia.com>, "Eliot Courtney"
 <ecourtney@nvidia.com>, <joel@joelfernandes.org>,
 <linux-doc@vger.kernel.org>, <amd-gfx@lists.freedesktop.org>,
 <intel-gfx@lists.freedesktop.org>, <intel-xe@lists.freedesktop.org>,
 <linux-fbdev@vger.kernel.org>
Subject: Re: [PATCH v8 02/25] gpu: nova-core: Kconfig: Sort select
 statements alphabetically
From: "Alexandre Courbot" <acourbot@nvidia.com>
Content-Transfer-Encoding: quoted-printable
References: <20260224225323.3312204-1-joelagnelf@nvidia.com>
 <20260224225323.3312204-3-joelagnelf@nvidia.com>
In-Reply-To: <20260224225323.3312204-3-joelagnelf@nvidia.com>
X-ClientProxiedBy: TYCP286CA0005.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:400:26c::9) To CH2PR12MB3990.namprd12.prod.outlook.com
 (2603:10b6:610:28::18)
Precedence: bulk
X-Mailing-List: linux-fbdev@vger.kernel.org
List-Id: <linux-fbdev.vger.kernel.org>
List-Subscribe: <mailto:linux-fbdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fbdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH2PR12MB3990:EE_|LV2PR12MB999097:EE_
X-MS-Office365-Filtering-Correlation-Id: 559c2de2-0f78-4406-99a1-08de778fba50
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|376014|10070799003|366016|1800799024;
X-Microsoft-Antispam-Message-Info:
	pEylAOWf/WFsfgmr29S89ZcvAX2M8ILaLBtf1kfWYoFluSUR9Vvub+xV4X3o7N4r7KqjsR96WO3KKNReT3m4Gry+PeJK9Z1N3FE+X0Z88d1e4sutKxLmRrz/C5oPIUt2wgWo1Em1VZshDqwEXfIh/1k4cRQFrTZNU7QrZiY3ZmxlpWmARDotgeIOC9kluL100/q12e2geBDRTU37WlwZb00BrKqpOtV0JiZ6N/F1N7fQYWveQ9Wk4z/Q8eUbrNSl+O1s1dk4HRKYhgjlymW763wSuQl03rcEZgeOqNOqbno/51iHa1RyhxJUg9UImdL+8HZ87g0YJNv2MYeQFqZ9G2YaROcoib3OV8tTlK0FCFhC0bSEty7G5UP/RefSaJz7hN8V57Dl3gtcZ7h1nwWlxnU69BgsmWP9nxI0maXAdEoNAncoFo7BnYRrRKvWQidPFk7egn3/ey7ZNS+WsRiJTw1xUPFCTiZsciXkMQvIWAgaeL3yyASyzB+uT2sxYsl7ysD4c0JaYrb4vW5VTwqWhtntDAKOjK26j2dfRrdop30Cf2MCtbn+QBIknFt+BArCAQzNRQnl5+jSaUHe0saNTITdhu2WePXCNSIoaEhrtNIE2TThz85Vl3QFbl9VcONp4m0XMwAJDtCzsxKSs+XkNdZbXa5RaRPdLT7QD3FO0altnR1BvRWUDH3pVhcXWd2/gtuQmM5zxvXwMdeYaArKahlOHeRGocj0iM9v02a0xQE=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH2PR12MB3990.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(10070799003)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?Q0t6Y0hXQXVHc0NrQUhOODFSTE1DWm1iWHdWZ3BJQXY4R2JlSjlmdUY1MDFi?=
 =?utf-8?B?bkoydFdpZEVSbmpPNTJwd0hDS3ZDWXBlU2c2aUFDYjY5Qi9ZN1NZbTNwamdC?=
 =?utf-8?B?ZS9wTGpsOVN4d2g5WE10TzQ2WlNmSUZadTk0cURkTkdiOUUwWFd0ZUtLdXdV?=
 =?utf-8?B?OW1keUN4cjd4dWNycE1Cd0tVd1dvbHoxNzhETXBBKzR4Q3JUeWw2c0Q0ajBi?=
 =?utf-8?B?QWU1c1NJQW0xend5eTNCa0hXN0t5NDZTZzduTDZpcnVBRUNGbTkzR0paUGsx?=
 =?utf-8?B?c053RTJJcER6UGdLaXJobmpVbkcxdlpwZ080RDYwWUNZTWpKOTJvWFlod2Zt?=
 =?utf-8?B?aHJrOStGQXJleDB1S1hyWU9rcm5mdHpyZnlwN0dlMS9ydlYzWWxjanpjaHlX?=
 =?utf-8?B?SDEzYW1HZGhVd0hpK2lKVVVpekdsUnFRdkR1U1JzWWRFeUVTaHhPa2J1M1hm?=
 =?utf-8?B?aURHOVFqeElVQm9GTXNhUnlpOWZJQTFSYWxhMXVibnVYQlkvTDhYMkYyclow?=
 =?utf-8?B?RFg2NlprTXMrZWtyK0JaeUlCa0VYL0VhU0NwN0x3ZkVwamNBTU05R1JtbjJs?=
 =?utf-8?B?NWl2RUNESkxDQUx3YjZySkdVVkNWMG1tR0J1ZUZ0OFZRUFVPMkJmTjA2aEts?=
 =?utf-8?B?bXVHTXIweXpzSUc3RFVvSFZpV2dRZk1oa3g4Z3dYUldzemRjWVNpSStJRmNZ?=
 =?utf-8?B?eDVRaEFuaWtrYkhMRGIwdTBaTTdiV2NleHpiaU4ySHJDYk5IWjNiKzhtSVha?=
 =?utf-8?B?SzVwWXNrU2dUN0p2K1JIMjJHbk9NeHpTL3RVMnVOOFgrdkVObnQ0UVl6Z2Z2?=
 =?utf-8?B?cTNBd0Q2dDl6YXRpU3RlaHozZ2pUWnlLTFZqaDJrMWhLWEg2Rll6cHFGT05N?=
 =?utf-8?B?UGxTbCt6bHlIY3JXM3Zka0FESmd6c2xma3NzRlZwNWh5bXRTcU52VHArT0hL?=
 =?utf-8?B?cDBJRWFkU1Rsd3lvdnMzWlk0Y0FTSkZDSTdZT0RENGZaWGdES1M0S3JYbjFs?=
 =?utf-8?B?UnNuUXhNQTdEOXIvWFJJaDh6bERKSk9qNUJ1TDF4aXZvYktxcm9IY1pjMTdD?=
 =?utf-8?B?VWZuRU4rMFgrMmJMVnZDYzV4eC9oU2U3eFllaXk3RjZwWFc0cTNCRTNBZWZF?=
 =?utf-8?B?R2c0aFlBQ05wUVB6MzVrMWprRDBGbVpqWUpoeEFITUtVVkNGLzFKUG1YcHho?=
 =?utf-8?B?QnQyeXRrU2tXN25wUzhQTXR6Y2FWM3JXa1dLQmRjbEppMDFwVGE3TThsWTlU?=
 =?utf-8?B?MVBuL0tCY2I0N2tYM1c5S21iVDVYR1c4cDJLTTdzN3N6OGw3UWgxdElSTEdn?=
 =?utf-8?B?SjhLUGFOZ2NzaWxoTXpMczRrYTJUOEczazZveHFBNVhpSndXVHRGRGpHNEtM?=
 =?utf-8?B?TWdjRS9TYkR0SCtZdExWMXg4eTFQNk16UGVDdUhUdTBXY2drN3dYVWNhR2pG?=
 =?utf-8?B?TXJjd3ptOGlGS2loTHpyS3JRcHF5WVJjNVVKNkVLZ2ZTSk5PVjZGcE51ZUQ3?=
 =?utf-8?B?emk5aDlSR3pZSWpIVkszb3pVb0hOYXM4TzlrUE1wb0VRN1VoV2dVQ3ZSOEVy?=
 =?utf-8?B?b0FKVDV3K3JtNEkxMHZFb1E3RzNnNTFqSHZ4RTlRVjRSaG96L1VwRmtzb2tD?=
 =?utf-8?B?bjR6ekdJT2V2K1o3c2ZBSy9sMDlhcmQxYmdaSGdtUG5ienNZaElLOFhtLzBj?=
 =?utf-8?B?UVRyUlluNEUwQXMwbXdlVDBxK2ZIbHNKUU9GK3N0MkFaZ3pVa1NJZmV0Vmlx?=
 =?utf-8?B?WHQ0VHpBaTk5bDBSRGhwUWRHNTFjOFJob1ZhcDdsWnk0bm5oS2tQRGRZQW1l?=
 =?utf-8?B?enJXQWV0RTJRRlNYVndoYUFqUjdBUG1VQlViR3pQcHVUMkpRNkt6UUErNDZ3?=
 =?utf-8?B?c1F5V0lxU2dTQWtPQlNrdGFwcmNKOXRkT0x1dDVkdUozaEo1c0UxeDI5ZWI1?=
 =?utf-8?B?SElXV0NQd1ZYN0VpUHg3dWRXZkI3RHFaSDFzU3g1djRHN0ZzalV2QXA4Z1JH?=
 =?utf-8?B?TW0vTG1XM3czcVZMbEFjeXdiMUJEWnNoMkkzeEZmbXFvTjdQWmdUTC9qNVcx?=
 =?utf-8?B?emtYUE1GOFFJRE5IbXl0a1l5SWsrcWpBdy9DQ0xpM3NuSVlFdnc1akZOb2V1?=
 =?utf-8?B?MXlXM0dUbWRjRXpsS3l6eEtjNGRYWityYjJFVlMybStKM2Vhb2ZkQVBkbTdR?=
 =?utf-8?B?aEhNak43NllPa0hlaUN6QkpYZXVXN1lKaUtuWmovQ1E1ZTMyTy9iYlFYK1Fa?=
 =?utf-8?B?WG9sU2Y2bUpOK1duM1RVaVNpWVFVb2xTS3lCazBXeldSdlk3Q0RhWWtnRzR3?=
 =?utf-8?B?eC9zVjNzeDhUaktFTjdlaTloRng1TmhJZERYZ1dhWHpJRTUvTkE3NVRCU1BO?=
 =?utf-8?Q?n8f6yFxh6EJyR2LMvT2Exk9rXPpjB/Y0jmu9O3MUj+LQq?=
X-MS-Exchange-AntiSpam-MessageData-1: F7SEb2LjdJPRQA==
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 559c2de2-0f78-4406-99a1-08de778fba50
X-MS-Exchange-CrossTenant-AuthSource: CH2PR12MB3990.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Mar 2026 12:40:32.7006
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: S/VXdDPjVUGL4Y87deLkk4xOpDCcXcj/82pWHcWXFSVJdr4xyCV3nYWBvyhVqtQ2O00DD8gjmrI5w614msIPaw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV2PR12MB999097

On Wed Feb 25, 2026 at 7:53 AM JST, Joel Fernandes wrote:
> Reorder the select statements in NOVA_CORE Kconfig to be in
> alphabetical order.

Nit: please do the sorting *before* adding a new dependency - it is
more logical to fix the order before adding new stuff.

Not need to do it here, I'll apply this first as it is obviously
correct - please just rebase the series on `drm-rust-next` and resolve
the minor conflict in Kconfig.
