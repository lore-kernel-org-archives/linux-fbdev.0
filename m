Received: from SA9PR02CU001.outbound.protection.outlook.com (mail-southcentralusazon11013037.outbound.protection.outlook.com [40.93.196.37])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7ACB1332EB7;
	Wed, 18 Feb 2026 21:21:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.196.37
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771449696; cv=fail; b=YiR89sFxG5S3PZvv3CrNNPPHdUItciDOfV7/l6K8gVREpRjBZfDXtY/RSNHRsZhhF33A21akf/J9wA4tiRdrvqi1nrST4GSDEedq2UiadHHelZ6Y/cXZr72ssHoBQnNUi7EZoZaKT7ker/awdpi6U9/pQLR/heBGf2fF95QMmzk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771449696; c=relaxed/simple;
	bh=e7M99vhCgfG80LYmbxTChFZuT6bVWjXI4IyvUvkopV4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=U4XLbMNKBJLuHMarMMBDHDuu+PTW/yiDyrlgwxAOyU/wnf1YPcmCqFy3zkDTnfYbsiGn0V9a5MZgiDsHVrJZl0vrkwSMbh9a8+j58T+7U3YjupR/g4bY4QCQlwv6UcTdCR0r951lVTJMAVohl4u0w5UYGXK6+6KbSEu7vo3tFxU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=o8O2w4Bd; arc=fail smtp.client-ip=40.93.196.37
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="o8O2w4Bd"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=aYzj2BC6Zir2HwVFuodg2sskapA3WmL8acoIX9zEmHvEbc3wVkfgTpfXbsr9ixDtv78JdNQSC0Cu+lcnB2t6unPZW1HHNzBfdTfgjICrdUMmq5U1bBcganCLeHIn+4zHfAqBXyC4SkLESQr0UXsuQNdFBQ0W/kD0zp0E3/cHSFHzVeny2W3Q+gCeSx8n/bnXZFw4Sn8jGlArx7ofa5NwmWGmJH8K+XIJLoOFw9jWOHvwHDaeiCC/AIbl363m+yy+Mx0OtBGFq4Eet+fhh+IdQt1tfVZgbSzbEv7D7/xUWG5JAXG5kUk9wEkky6NdcEF6ZBQPRD9O0BhxvMV3b9KEcw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=q9w3sq+e9q4uNIMFDdk1gJj2+ScZsyWxkYVau7dy/TA=;
 b=KMagsKOLfFPbzgx964SQu4wiIvXU9wswbfHAru6UNtCOhgMH5uiPdy5EXhfV6zW05/Lx4MboZExT+FqGUbsWDzURUU39S9bSVx6o7hJavn9l/zdMEV1+E/orGJaUbhkZUwF2yiygOY3DAxNeAI6dIdkJb5UZ+XB3ximZ0rFQ93KJANrKSchz5zo2eMLFhvC/bI4//rTRinKTZ0leHoq6c8DF5UfMOzV7Bsy1ZJ6iY6aY6R0BZkl7toF+AQk/rtLbvk9FlbxtHixCw/UMadKVet9e/0Z0JhoLAMvL5q6FTOXaylRNqwfIqqjSg5oYffgaVk+4mGRakfEYCj9WIg39JA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=q9w3sq+e9q4uNIMFDdk1gJj2+ScZsyWxkYVau7dy/TA=;
 b=o8O2w4BdHb8TNFpRNwBHHu8PKTez24erAIZyUZyDA+E6cZxoCBQCAs8nRfS0XRJpaXCf0nwJVVCIn1pT1Kl6lF/w/sjFOaR3fEDYhaiMRzrZoYnRiq0sPTV1YjTrKgzgiGM6x9Q1qIcokj+D3znhSc3VQ/ZRL6zjCG1JnJyAGymR0mI3QQg5AfQF4ssd7FwMarCTg+cDI+/u7wr6iEobmSM6Pm7VCwBJz1xmTSzdAmNEQ2IaFVbCnDm5oOV7XTj3/nSoyIWVP87lAioNgT1Z3DG9zzpQcfbqkPmF6OsBXqFOzmsxOIsRkHJz4Ijt1yOBce2DmMftFjLeAWs5c4TaLA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DS0PR12MB6486.namprd12.prod.outlook.com (2603:10b6:8:c5::21) by
 PH0PR12MB999111.namprd12.prod.outlook.com (2603:10b6:510:38d::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9632.14; Wed, 18 Feb
 2026 21:21:26 +0000
Received: from DS0PR12MB6486.namprd12.prod.outlook.com
 ([fe80::88a9:f314:c95f:8b33]) by DS0PR12MB6486.namprd12.prod.outlook.com
 ([fe80::88a9:f314:c95f:8b33%4]) with mapi id 15.20.9632.010; Wed, 18 Feb 2026
 21:21:26 +0000
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
	Balbir Singh <balbirs@nvidia.com>,
	Philipp Stanner <phasta@kernel.org>,
	Elle Rhumsaa <elle@weathered-steel.dev>,
	Daniel Almeida <daniel.almeida@collabora.com>,
	Eliot Courtney <ecourtney@nvidia.com>,
	joel@joelfernandes.org,
	nouveau@lists.freedesktop.org,
	dri-devel@lists.freedesktop.org,
	rust-for-linux@vger.kernel.org,
	linux-doc@vger.kernel.org,
	amd-gfx@lists.freedesktop.org,
	intel-gfx@lists.freedesktop.org,
	intel-xe@lists.freedesktop.org,
	linux-fbdev@vger.kernel.org,
	Joel Fernandes <joelagnelf@nvidia.com>,
	Nikola Djukic <ndjukic@nvidia.com>
Subject: [PATCH v7 13/23] nova-core: mm: Add Virtual Memory Manager
Date: Wed, 18 Feb 2026 16:20:10 -0500
Message-Id: <20260218212020.800836-14-joelagnelf@nvidia.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260218212020.800836-1-joelagnelf@nvidia.com>
References: <20260218212020.800836-1-joelagnelf@nvidia.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BN9PR03CA0448.namprd03.prod.outlook.com
 (2603:10b6:408:113::33) To DS0PR12MB6486.namprd12.prod.outlook.com
 (2603:10b6:8:c5::21)
Precedence: bulk
X-Mailing-List: linux-fbdev@vger.kernel.org
List-Id: <linux-fbdev.vger.kernel.org>
List-Subscribe: <mailto:linux-fbdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fbdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR12MB6486:EE_|PH0PR12MB999111:EE_
X-MS-Office365-Filtering-Correlation-Id: 44fb9631-0317-4ddb-8865-08de6f33ac77
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014|7416014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?6RrPiPSlpbb+y3B0DMIJamo3uFFhBkYXS0wM2VbOZipq+UvW6Nm9D6lLoPHl?=
 =?us-ascii?Q?sVpLPhzvKxdpf1ucZqeFdbaCsbthTuJv6OZsGKjuvdZjnOhpsej12eVmh1/0?=
 =?us-ascii?Q?fbqytXCwFYi1GdeENhxYodICChN+Yt9g5BlBIGjqhp7ntK6rx1l15Dl1sIcj?=
 =?us-ascii?Q?QL5L2hFKOIabGVbNvk5jK1R0REbF7fm0BVC0AeqFmymQ3iJkCIcgtXJQxpoj?=
 =?us-ascii?Q?mdv/lJTk6hh4lceJebBNS9vJyBNs0aDmUDDq4WRdiQS6xt2X8oEv3pBTYypL?=
 =?us-ascii?Q?avoCAp9C8OdmRWkugam9y7URHiycELegU2YUqFlasUJmESbUEvuyOnrdkqNp?=
 =?us-ascii?Q?4BfQ9ggwynpYN+Y9QN8TLNioqrd2At/k/oxqKNgDRvIErjCegqoFrGOTD1wb?=
 =?us-ascii?Q?wCOGyOGecPfr5rsnfGIQp0pqmVNSnZ5M+ytRfpXZekv4oV15TI7KBQyNlAWZ?=
 =?us-ascii?Q?ZxqQzDzU2ePv3Uhsk6Wwz7vy7u9J/Acvp6cM99ESsFY5ZlZHUNYh07+Gza9z?=
 =?us-ascii?Q?FC/ptXHS31GWHn6oxn0iZaqBVKrMfH0KLnvTpOsSC6k+75jCqJZUNdEXrQvZ?=
 =?us-ascii?Q?AEbk/8QAQd55CO0RZ3JsN1+2HdcWs5hLM+d5Rgt1moIXBZIuP8TXaH6D6/gL?=
 =?us-ascii?Q?UXCGrLXAVSlFhHZeNlhYPlgkPZwvsuLAWZDoM16U5Bo/BaludpRju4fUVVeK?=
 =?us-ascii?Q?EhU7c5qu3KRPCPiKJzDJjffMzgfjAOiUo5ayMmwueuafMrcz+yVWbOwJNw4d?=
 =?us-ascii?Q?ql5iK+J7DQbFRn+HpB0KCtZB+NiUKlcOJGotwJyQOzmHHLtoxsToFQdIWCyw?=
 =?us-ascii?Q?5pSoGxbzslWjEEmunZVWxWmuDw0Bql8ygP0zKwKUB04oaojAnkgX//W8R+3x?=
 =?us-ascii?Q?74qF5GUJb5KBFf0db9uuZHdyOTzZgPfMopBXhiy4WJJ1qAaFsRR6YDQRHvRi?=
 =?us-ascii?Q?TUfKmUJ7VVdUuARTHe/Hr/vRm/3p1tXjBllbO3gMrqEXUjEGC4W/W1wxh2CY?=
 =?us-ascii?Q?62HI8JFcjlvrFn5Ho+iOoxhSXQfcasEk41f8wBMTgIKOwyc0y1hJCBiAikI7?=
 =?us-ascii?Q?2h56ucv3jzZu+Zr385NPMWHMQV5q2UM83MmGEq7wM2YbL9gPwX2M35sl9fp4?=
 =?us-ascii?Q?sdJ3mF5mR/0NFsZyIe6bNjEaBWzt98MQN6SsLnLD6nwrM0L+ZAGXft/ilZrS?=
 =?us-ascii?Q?hfDStXJBOeeEppL+/2A3gYiMWsfUP5rAPWyrNfwag/1rb/kTLstyCUfQL5GM?=
 =?us-ascii?Q?oKJQM59ecXWvl3GsRJzWFUJlpN2wJY691wX3rlHAaIFNTLerdH40+csvDF+7?=
 =?us-ascii?Q?XA/X4USsfc/5BfXYUQQca3UuP2dzJi8Xjs0PYJyQ7BbgNbB0jL0rTiVOgIAl?=
 =?us-ascii?Q?YGeGrZdTr5z9+YtbVN/7A6Tx3Jes8Ffme1UlQizUALBQaIF8TjbVy5bEIMiJ?=
 =?us-ascii?Q?OwuXneI3EYrNqTRV4ESkBE7xXbpdtzySgGyBhZVPx939KL+/RMv6v8bTjAEQ?=
 =?us-ascii?Q?GwpiMqigSiHENeKtAe3VzDAJtLFyx3rh/oh4VZUHPrQz+6X4Mww29C04zFNJ?=
 =?us-ascii?Q?1SAKFR06FCMXmWw2fBU=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR12MB6486.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(7416014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?rWxXr1q9VXTFVqMjU2rHTtDhsUKVd1H/C9Upr/9rmJa+qvUjEXPFcMuh3sZG?=
 =?us-ascii?Q?KGUVFrb9Wb1q5hkkI8o3EpdtbmZ9DpW0TrdoIMbNtGH3Si92aHusRwnvETES?=
 =?us-ascii?Q?kLrGr65dRTYDkeBqibLVOx9cNtvWdaJQdLFXdsGrMiu97a20JJ5rkhMJvMg4?=
 =?us-ascii?Q?Mbg12wxvuGQ9iV98SXsub3UvMqxHqiwM45OXo+7+09ygR7XEmKPj2vhS7o8v?=
 =?us-ascii?Q?297RyXwiwGVpsucECkXXuhmnLuxVfoPoGoOihHOcWTvvAkw/6LNP6zTzbCGS?=
 =?us-ascii?Q?qHPvctEL9PfN/UOGNUOD/KpcIVemscG4Jw49TZjAO5eeWJidvzR6e7QxUGAx?=
 =?us-ascii?Q?Y899XbKCwYrLaUaff3bQ/ZulBickBiXqZxEHD9xVtbvjwHbIVfur/lQDJnzZ?=
 =?us-ascii?Q?9jfxVRZrikl4z/W5L9RrGdMy4aRlAJqAqnrUUqRcWmi4G3TtihpB1jR2kH3L?=
 =?us-ascii?Q?8q3+luui7GQ9nBsHkvchFnISyzGCiLouxDn9vzTGwBi9EvUaImr+/vr5olZZ?=
 =?us-ascii?Q?z4ca6KL9cC4P7j5pyqeBCdOKZW9GXzDvmKctCMCH2NfJshq6btjBsu2nVMJF?=
 =?us-ascii?Q?u+3A1tcpc3TAnXbsFK7ZFFtFL7jok9S/zm/QM2SuhI8YXCG0hrN5mp0qm6To?=
 =?us-ascii?Q?NyZ1y26VHs0By8J/ieylPkSXaxMoD+UjWrMcGfsvj2C98E3NPtxalewdgl20?=
 =?us-ascii?Q?G1/kPhnLsuEfKNd4NTZMfuCmEHGPOCBEsLYXOWOEoOzQfVTZllLgh567AIeZ?=
 =?us-ascii?Q?muCE0R+1TnBUAg+qTkUWdhi+T8I9LAR8rosN449hjIfk9hbNhFG9hcv163RM?=
 =?us-ascii?Q?JNFmA6DJ/1DBgtqlQygAg456rE2hPTTy7SXHx2U4rMp1E8MPx8wfjHti35CW?=
 =?us-ascii?Q?ceM6X58DcNKjB9zDhaD76vdjO7qAzNykqmemQp0KY2o0LiopF+/RSSp0kkDx?=
 =?us-ascii?Q?oOI679ywMIt9qytLTd4hCYe3w8xWdtcswWwRw96Whnlt5gCoaNo2Bz6YwcKZ?=
 =?us-ascii?Q?ftBzxImPFTi6vS+bqm1UJipMKDoT0/LVObExg8xI1z679hNOvmA9wv082ZYj?=
 =?us-ascii?Q?XliuashGjMaE5Cg9vy7Byl1NVHQSl/cQeOmNQ4Gbt7kwhEzvIZGDOd6HM2qn?=
 =?us-ascii?Q?l1koWA5S5N+FPuTunE8L6kGG5ubOrdJuSOOIX9n+Kb8x+MnlnDZ241M5AMKC?=
 =?us-ascii?Q?jfrGT/XAV3NmNvnS1q/C0ZDhiUiLXHEvzc1DiYcr51E63lX8etu+htHyUJ4y?=
 =?us-ascii?Q?hx0ENF3Z7+HCyB4N6xr5VKgyTezWaaFVu13OaLJ2shoF+X/X1GC1YP3I7Pil?=
 =?us-ascii?Q?C4pR4y/+WpoqA1w21eFVfvnoXiOIhK3Zw90lr+khlgW00tfCBE8vtCJ0p2bF?=
 =?us-ascii?Q?Zurj5a+Vignm/SEJoH+Z0HNRKkAm1e38QTtV+MOYO/6oDH5BP+nn07Ws3Q/4?=
 =?us-ascii?Q?wlmiIP+yhFxsfHWXUPRp9FGwLUQmwc11mLyHWM981is+aAOGvflq79SQlCu2?=
 =?us-ascii?Q?+6qFmhyAkZE1DCwGPXEZxybiCNaJRqHLx9f0wJ9W7tgDzKdCYcrmWbZ/rFRG?=
 =?us-ascii?Q?XX0P+XwDAJeZgnPsEr0POPfU2zD2CWUak8sSqo6ptSYV+zF/4eJD/jy61tIl?=
 =?us-ascii?Q?uAvJBhRX2agF8jsOOpclf2IoLjQKQucQUbgu718HFciUbyGC5/HQXAfgapcb?=
 =?us-ascii?Q?jjlaprsxYo1+2/CYyy889Myz3B3fWmE1hK8m0l7P2W6W/oG2AdwuiSmdlY89?=
 =?us-ascii?Q?w5BrvP654g=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 44fb9631-0317-4ddb-8865-08de6f33ac77
X-MS-Exchange-CrossTenant-AuthSource: DS0PR12MB6486.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Feb 2026 21:21:26.2747
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: /HGE2GBNe89BPxiHKjY6QsGxWeIz8JiqDm4suYDu9YHCwXqbsGGUJOjv5E5g/m79ru9ujRTsPMy/K5BmuBlFaQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR12MB999111

Add the Virtual Memory Manager (VMM) infrastructure for GPU address
space management. Each Vmm instance manages a single address space
identified by its Page Directory Base (PDB) address, used for Channel,
BAR1 and BAR2 mappings.

Mapping APIs and virtual address range tracking are added in later
commits.

Cc: Nikola Djukic <ndjukic@nvidia.com>
Signed-off-by: Joel Fernandes <joelagnelf@nvidia.com>
---
 drivers/gpu/nova-core/mm/mod.rs |  1 +
 drivers/gpu/nova-core/mm/vmm.rs | 63 +++++++++++++++++++++++++++++++++
 2 files changed, 64 insertions(+)
 create mode 100644 drivers/gpu/nova-core/mm/vmm.rs

diff --git a/drivers/gpu/nova-core/mm/mod.rs b/drivers/gpu/nova-core/mm/mod.rs
index 471f8eb0635c..922479accba6 100644
--- a/drivers/gpu/nova-core/mm/mod.rs
+++ b/drivers/gpu/nova-core/mm/mod.rs
@@ -7,6 +7,7 @@
 pub(crate) mod pagetable;
 pub(crate) mod pramin;
 pub(crate) mod tlb;
+pub(crate) mod vmm;
 
 use kernel::{
     devres::Devres,
diff --git a/drivers/gpu/nova-core/mm/vmm.rs b/drivers/gpu/nova-core/mm/vmm.rs
new file mode 100644
index 000000000000..eaee707181b5
--- /dev/null
+++ b/drivers/gpu/nova-core/mm/vmm.rs
@@ -0,0 +1,63 @@
+// SPDX-License-Identifier: GPL-2.0
+
+//! Virtual Memory Manager for NVIDIA GPU page table management.
+//!
+//! The [`Vmm`] provides high-level page mapping and unmapping operations for GPU
+//! virtual address spaces (Channels, BAR1, BAR2). It wraps the page table walker
+//! and handles TLB flushing after modifications.
+
+#![allow(dead_code)]
+
+use kernel::{
+    gpu::buddy::AllocatedBlocks,
+    prelude::*, //
+};
+
+use crate::mm::{
+    pagetable::{
+        walk::{PtWalk, WalkResult},
+        MmuVersion, //
+    },
+    GpuMm,
+    Pfn,
+    Vfn,
+    VramAddress, //
+};
+
+/// Virtual Memory Manager for a GPU address space.
+///
+/// Each [`Vmm`] instance manages a single address space identified by its Page
+/// Directory Base (`PDB`) address. The [`Vmm`] is used for Channel, BAR1 and
+/// BAR2 mappings.
+pub(crate) struct Vmm {
+    pub(crate) pdb_addr: VramAddress,
+    pub(crate) mmu_version: MmuVersion,
+    /// Page table allocations required for mappings.
+    page_table_allocs: KVec<Pin<KBox<AllocatedBlocks>>>,
+}
+
+impl Vmm {
+    /// Create a new [`Vmm`] for the given Page Directory Base address.
+    pub(crate) fn new(pdb_addr: VramAddress, mmu_version: MmuVersion) -> Result<Self> {
+        // Only MMU v2 is supported for now.
+        if mmu_version != MmuVersion::V2 {
+            return Err(ENOTSUPP);
+        }
+
+        Ok(Self {
+            pdb_addr,
+            mmu_version,
+            page_table_allocs: KVec::new(),
+        })
+    }
+
+    /// Read the PFN for a mapped VFN if one is mapped.
+    pub(crate) fn read_mapping(&self, mm: &GpuMm, vfn: Vfn) -> Result<Option<Pfn>> {
+        let walker = PtWalk::new(self.pdb_addr, self.mmu_version);
+
+        match walker.walk_to_pte_lookup(mm, vfn)? {
+            WalkResult::Mapped { pfn, .. } => Ok(Some(pfn)),
+            WalkResult::Unmapped { .. } | WalkResult::PageTableMissing => Ok(None),
+        }
+    }
+}
-- 
2.34.1

