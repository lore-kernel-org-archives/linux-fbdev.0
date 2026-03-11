Received: from PH8PR06CU001.outbound.protection.outlook.com (mail-westus3azon11012001.outbound.protection.outlook.com [40.107.209.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C802D367F45;
	Wed, 11 Mar 2026 00:40:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.209.1
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773189641; cv=fail; b=czXoXVyN8xHSmTnu/FSLuthFccpa1wipbaBTjCbvbrzLIzKzwenyvb/aYOKJD41ocJU4jUWpDoWO3aGQEbKjA4jm77OAl0PLinVW66hgtwDqZO88WpKnlPFNaqTNMsSw+vZG2vXXHXby4bUtcSHX7P9wDuBoLHV3hrAYzd4z2hQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773189641; c=relaxed/simple;
	bh=B9kJpCDm82mZNBTBojOuDg1Dsj+Q23eBcJ9aJWx76zs=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=k8At5sJstTiukvh/O/Nv2Dfzga/EtXIB6tL+kJLQ4We5hBwdqqhQC+IJMSKaTnOyOoSUtxmPZ3B/ZI2/8XkJZoB4yHG1BpU7Q7mQuOkNrDMmMkUxoYsX6HDHnUWuzlSy0bNKpbW1VI5kyJa5UhKCQ+Tm2ANQuha6Aj1K5MaGW08=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=U5WX27pd; arc=fail smtp.client-ip=40.107.209.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="U5WX27pd"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=sROr3RKXawodSB7SaInBy9lr0GKdQwmB/a7/EgqkzoGOdiYEhqnu+biy3Mw8KsFzZ4/geIZ8QhyRKi0UCE2Mt3dLfdyN75+KjVIDna7r7iwXOsnzdnq7TBf7/fzKH+/Ry1GE9qe6Ky5p2EY/+g2p8tDaj5EQL17Be6g49TS7AIMmZiNubllhZFEgABcQrMVNol5Bz+/NfiAqEhhBDrdbNg9CbMpwYt16LSeWiGw2wlsStaot4+PYLGBYJlJHpcEZBWOoref5K8PBH0+tBrRQreg7Q1Q48dLMUpOZW2PPxxRDpH/KgbXB2ngpDp8Hk3hDd0HayxmEb0UQyhy8rmAb4w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tBvNe4Z/lwB2ojAL9MkLMIqcL14XinV8H91fEJRaV08=;
 b=PCoXOi/kwDOiNJ4VTx0x6DJRkVdrtINlaSGxJvUgwIzuOIy5E5d550Df3pq5d85BP5gK11FialrCi9zlWtjbgTLgfsMN6J4ZjLgt9Hbsym9YABwDSVCkLDAIAF16NAO4veJJ/zTHWgvuCTL9HuEEP6HQm9BQ4K1HO7z6BxBXdEPHP6OlKaBhe+BVE1Hr9zn+70z8OUyilrNlapt6KQFaymUN9/Qdv2ROu65TDDaMokYE+6Pox60Bxd15CDTsmFK4Ez7q1R9wXp5W6rnfaX6Obo65mkgscFL+0F9dnzcMTYk++JDS424JjankPBK7fn/m06sO7rV4D4KdmL6xHhcmgQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tBvNe4Z/lwB2ojAL9MkLMIqcL14XinV8H91fEJRaV08=;
 b=U5WX27pdlm0hcJNsxCU08rGHahL+LUa19X/HpVQ3CjlyJh/P0JWpwAsycMGdQlSjBWAI2G8zSSBn4Oy2ZpjaExZ3CwwtHF69HZMAcSwTaU4JrETPkAorCRlnGA9ZaawzWYEBY1WsTs3Atc9K2jTPNdqTLTCFJJomDftVx8vXnKkOfnvPS7b98JYhngaRYsngRjiuboshoOvYoJzzlYrCLgF1F365gRIwrIU43IEDVlZXpvCBOxE29iJjpwmqsl7hbT7PCwzFpvXmEX7MPGczlO8MIvqRGxZDz6128D5BLJ3RMP8Z5kGOlOW0Olw+7igB003xY1eHR1ruw16X0hPZuA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DS0PR12MB6486.namprd12.prod.outlook.com (2603:10b6:8:c5::21) by
 BY5PR12MB4051.namprd12.prod.outlook.com (2603:10b6:a03:20c::7) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9700.11; Wed, 11 Mar 2026 00:40:29 +0000
Received: from DS0PR12MB6486.namprd12.prod.outlook.com
 ([fe80::88a9:f314:c95f:8b33]) by DS0PR12MB6486.namprd12.prod.outlook.com
 ([fe80::88a9:f314:c95f:8b33%4]) with mapi id 15.20.9700.010; Wed, 11 Mar 2026
 00:40:29 +0000
From: Joel Fernandes <joelagnelf@nvidia.com>
To: linux-kernel@vger.kernel.org
Cc: Miguel Ojeda <ojeda@kernel.org>,
	Boqun Feng <boqun@kernel.org>,
	Gary Guo <gary@garyguo.net>,
	=?UTF-8?q?Bj=C3=B6rn=20Roy=20Baron?= <bjorn3_gh@protonmail.com>,
	Benno Lossin <lossin@kernel.org>,
	Andreas Hindborg <a.hindborg@kernel.org>,
	Alice Ryhl <aliceryhl@google.com>,
	Trevor Gross <tmgross@umich.edu>,
	Danilo Krummrich <dakr@kernel.org>,
	Dave Airlie <airlied@redhat.com>,
	Daniel Almeida <daniel.almeida@collabora.com>,
	Koen Koning <koen.koning@linux.intel.com>,
	dri-devel@lists.freedesktop.org,
	nouveau@lists.freedesktop.org,
	rust-for-linux@vger.kernel.org,
	Nikola Djukic <ndjukic@nvidia.com>,
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
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
	Alex Gaynor <alex.gaynor@gmail.com>,
	Boqun Feng <boqun.feng@gmail.com>,
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
	alexeyi@nvidia.com,
	Eliot Courtney <ecourtney@nvidia.com>,
	joel@joelfernandes.org,
	linux-doc@vger.kernel.org,
	amd-gfx@lists.freedesktop.org,
	intel-gfx@lists.freedesktop.org,
	intel-xe@lists.freedesktop.org,
	linux-fbdev@vger.kernel.org,
	Joel Fernandes <joelagnelf@nvidia.com>
Subject: [PATCH v9 05/23] gpu: nova-core: gsp: Expose total physical VRAM end from FB region info
Date: Tue, 10 Mar 2026 20:39:50 -0400
Message-Id: <20260311004008.2208806-6-joelagnelf@nvidia.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260311004008.2208806-1-joelagnelf@nvidia.com>
References: <20260311004008.2208806-1-joelagnelf@nvidia.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BL1PR13CA0289.namprd13.prod.outlook.com
 (2603:10b6:208:2bc::24) To DS0PR12MB6486.namprd12.prod.outlook.com
 (2603:10b6:8:c5::21)
Precedence: bulk
X-Mailing-List: linux-fbdev@vger.kernel.org
List-Id: <linux-fbdev.vger.kernel.org>
List-Subscribe: <mailto:linux-fbdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fbdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR12MB6486:EE_|BY5PR12MB4051:EE_
X-MS-Office365-Filtering-Correlation-Id: fbcff48f-5f68-45ff-b1b7-08de7f06cb82
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|376014|366016|1800799024|18002099003|56012099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	hVKjeiY8h+j3XYQlCrVremOStlwFsT5J0fAYFUqPSHFGbpuKXjLdqgK2ZbGTTFww99n8b7hXTaO3pAgQtJjKynm0hK/KELDLt0amRsi4Gd0AbIJjjorm4ARheHPj6ivfljyX05zlCoCeI3LCTRgTRIeDzuxMZFyWZ1EHBjeqjthYX/+5hHf/PTRt7Q0orhED5CtMQFKhZ76Y7RULiquSmiX9kPJnQZbtcloUGbs9wYOnOCB5HMQ7jXtuzIDhWGplD68gok1e43vSRLlAvi5+bJrJ7KVAKjjH0gr5Nti5MUtioM+NuYp9pA1NeHX+mZuUSnk9iymj7hZ0f2MXbkLrtRg/e1KW7dd5Dwuk66DR3aG/0NUAdQngvyoJYrd03iJayeCESXTPnWFk1rAYyvyxqVOh0WxlyLRpVO2RqY01EPLZS6gCQu/CvmNPuhLnB6rFSTtqU6X3DhM1CRhvDUMUtHgm6ccrrOY4hLP4+EuAZgs+ug35qpwpLwU7M86VD1ORWkxVQZttCbmgf1MQ501GvsibWxdMH0z6dnvs7qU9e8bG/S9oNhowLPqOuzHR4YNpE6GpbgDQS9wPRG4eUzCosmGcX9PbfO98XZ0IGMV5Z3GvVhSYPgn2ikjIPIf60FaFz+4GJTW1TISCSHwvIB8llfGErHB4lQpY+3cQM9KOnCtLPZwAQA7y96rJysuKovV3ttLyV/H042eRwubeSIqSkM+oNH84FyYQh/JFTVxrEgY=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR12MB6486.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(366016)(1800799024)(18002099003)(56012099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?2nx+HfpWzvsz5P8skv4TARxnxZeMyoFXllZqK+yJ+TjAnZetv98a5edyYX1m?=
 =?us-ascii?Q?K+VXcRt7OZuSsUuNpIMFUEv0iiOKDdx3oppbgC7jLu0/8Pt4brB4zn4pNqyq?=
 =?us-ascii?Q?VUwRu2wdVIo88ehrO5hSBfr2eTjcC6F1Bm0KtJpNaLJ9kUEmjRD2b+zyexLY?=
 =?us-ascii?Q?f3RTpyMwUy4yWRF9nzWGyks/WTZTN5TP1si9BSknGoRHJNNqHvd0/8SfMB1z?=
 =?us-ascii?Q?CX0J7A/PuqS69YNQuf01Rkdf4OipYuMYvSu4cSYUZ+zC9TvR6mcV1opX4PSW?=
 =?us-ascii?Q?VepL2NkLbANx0w7E8KvVYKetb924x9OcQBCcQzFr+5O6Zx7pLe/g5T49PD57?=
 =?us-ascii?Q?676ilJ8MP3KIapD8SUUa2IhGChGBzKqXNyDP/+vZBLOQqdwjB+Q0Lb2uSUfd?=
 =?us-ascii?Q?RDRoE70ZPd6qVf8moPCUlqS937ZvACR3LKlZHVpdfBVf+QZ7R13WGOQO0ypZ?=
 =?us-ascii?Q?72t1/M+jPi2Wl+BTA2eAfyef0AlNVcRYzvz1aaB6uolkGYNKaMsHReJ+KzEM?=
 =?us-ascii?Q?n+Dz1xX4lojspKGEJiupGkoiOiIURxih3Ow9FwP/q5NJcx7B33Ntk5ElVnlO?=
 =?us-ascii?Q?uiIxc1bkQr3up3994RIjRV7Ad9zSF4rEpiDsGp34L0Xs+SY+29AD0amR+J5c?=
 =?us-ascii?Q?QXdaYJmnbcIsJNJSutiA518WOU7odAnTbDZXv329zvwNj0FLZjhTAb58DQYt?=
 =?us-ascii?Q?V2vIeoWz3wkrZLKzMFShW0pa7HOJSVaphFsJwjDDDR0TDcBuhXewaYwtQwAt?=
 =?us-ascii?Q?aeb8PYPDlc0DrEqPZfr7ErK+Zk4fS7bAGXBYyj9nKlnGFGI/KCvPu2wweZ9I?=
 =?us-ascii?Q?zqmOfvDx05zfiXf7kVjCeqraG6MsQA1TDLerw1bpjs2YZzrKGPvaVmT0fuLI?=
 =?us-ascii?Q?mAmRV3DrVc24H+vroH8EMizno8mP3lQqDf8OklCz+4SixcUuT71tTGSo7lZn?=
 =?us-ascii?Q?hheu5HYp+YaCI4y/F8wXLYuLaPhd7DQY7gAiwx1sJGLtaXfXZMoCTL+3M0NC?=
 =?us-ascii?Q?oFWzOfA69iUJHG78EGoFgusZhlYC3UAzFwskMt9RTF9Sq6fWfqVlyALo+Txt?=
 =?us-ascii?Q?GQIu4lhHkY50wbw5ZdN+1AtDT6oGT9O+W1ooF/fUyY/aMlQ27elwtE1EwpAU?=
 =?us-ascii?Q?y9F9O+MrtZoMJpkU1RbF2Wn8gEAEx4TDmBZsnMBAdfJaeBak7JmC/QfJltZ0?=
 =?us-ascii?Q?JbSYloYeE5ztoc4bhmK5Ak01MW02hcgBLUVSnnchqq3ijVmCB6/hjSGyOZMm?=
 =?us-ascii?Q?HC9m0pKJSIaHfX/oe61kYyQaPyESKpJrtL2WTduOK3wJouKsjBIVpYSzEZuq?=
 =?us-ascii?Q?biQ9t9IbEC7pkif3k/QQMAQH5whBrcQfN56Q8iOdFCiXDbTjHLTpflwYkAQn?=
 =?us-ascii?Q?349/OppjRalKAuAOb+XouFjykg+l9xu6x8lm8RBUpndoPwRAKRWR0PBXgPV8?=
 =?us-ascii?Q?YyUhblgohEPEnsjRNA2vltGQHeJnqjsYPZdHitewobdPDB88OJTjriaCttnF?=
 =?us-ascii?Q?O+U9cvsAwq7O/XFoefhUhKxhUjGyrB5Ss3bx3CZATRbl94JO35CHWzlkzmap?=
 =?us-ascii?Q?JxpSY+8fWMbOMtGIdYrAJXSkDRrdsed17NoCG8AL/0IT5ygt+KKGSWIGbcGx?=
 =?us-ascii?Q?BLVJmrN3Y1+noBoD6fDDTcKBRSPLWKie+bxniWsRaf9nxiEst1ydo+woyoeW?=
 =?us-ascii?Q?8RXY1xyAhUsdH2rWFRNizZE5BHBCM3DeF4xDOEMqMaBoXnQOzXVzQ/Dhpb1N?=
 =?us-ascii?Q?hr/90OcIFQ=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fbcff48f-5f68-45ff-b1b7-08de7f06cb82
X-MS-Exchange-CrossTenant-AuthSource: DS0PR12MB6486.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Mar 2026 00:40:29.6776
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 45/zmIHlu61nN3ACZZGnCK0QPK/CSC+kdPmNDx5dNEMIoSSe/6MQ3vUO/0M4UDrqUcD1o8zkftEsXidKf2QayA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB4051

Add `total_fb_end()` to `GspStaticConfigInfo` that computes the exclusive end
address of the highest valid FB region covering both usable and GSP-reserved
areas.

This allows callers to know the full physical VRAM extent, not just the
allocatable portion.

Signed-off-by: Joel Fernandes <joelagnelf@nvidia.com>
---
 drivers/gpu/nova-core/gsp/commands.rs    |  6 ++++++
 drivers/gpu/nova-core/gsp/fw/commands.rs | 19 +++++++++++++++++++
 2 files changed, 25 insertions(+)

diff --git a/drivers/gpu/nova-core/gsp/commands.rs b/drivers/gpu/nova-core/gsp/commands.rs
index 8d5780d9cace..389d215098c6 100644
--- a/drivers/gpu/nova-core/gsp/commands.rs
+++ b/drivers/gpu/nova-core/gsp/commands.rs
@@ -193,6 +193,9 @@ pub(crate) struct GetGspStaticInfoReply {
     /// Usable FB (VRAM) region for driver memory allocation.
     #[expect(dead_code)]
     pub(crate) usable_fb_region: Range<u64>,
+    /// End of VRAM.
+    #[expect(dead_code)]
+    pub(crate) total_fb_end: u64,
 }
 
 impl MessageFromGsp for GetGspStaticInfoReply {
@@ -206,9 +209,12 @@ fn read(
     ) -> Result<Self, Self::InitError> {
         let (base, size) = msg.first_usable_fb_region().ok_or(ENODEV)?;
 
+        let total_fb_end = msg.total_fb_end().ok_or(ENODEV)?;
+
         Ok(GetGspStaticInfoReply {
             gpu_name: msg.gpu_name_str(),
             usable_fb_region: base..base.saturating_add(size),
+            total_fb_end,
         })
     }
 }
diff --git a/drivers/gpu/nova-core/gsp/fw/commands.rs b/drivers/gpu/nova-core/gsp/fw/commands.rs
index cef86cab8a12..acaf92cd6735 100644
--- a/drivers/gpu/nova-core/gsp/fw/commands.rs
+++ b/drivers/gpu/nova-core/gsp/fw/commands.rs
@@ -147,6 +147,25 @@ pub(crate) fn first_usable_fb_region(&self) -> Option<(u64, u64)> {
         }
         None
     }
+
+    /// Compute the end of physical VRAM from all FB regions.
+    pub(crate) fn total_fb_end(&self) -> Option<u64> {
+        let fb_info = &self.0.fbRegionInfoParams;
+        let mut max_end: Option<u64> = None;
+        for i in 0..fb_info.numFBRegions.into_safe_cast() {
+            if let Some(reg) = fb_info.fbRegion.get(i) {
+                if reg.limit < reg.base {
+                    continue;
+                }
+                let end = reg.limit.saturating_add(1);
+                max_end = Some(match max_end {
+                    None => end,
+                    Some(prev) => prev.max(end),
+                });
+            }
+        }
+        max_end
+    }
 }
 
 // SAFETY: Padding is explicit and will not contain uninitialized data.
-- 
2.34.1

