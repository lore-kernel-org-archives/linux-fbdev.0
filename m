Received: from LO3P265CU004.outbound.protection.outlook.com (mail-uksouthazon11020130.outbound.protection.outlook.com [52.101.196.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 14D3732AAAD;
	Sun,  1 Mar 2026 13:15:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.196.130
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772370907; cv=fail; b=N8W0XZZTjQii5XYSEJh4Dz1vni02Z6U5k9jqqj/PP8DHxm++sZAOpFK3Q6YDcprtc0BdoLdEbmXcsJvvMIB+r+nVsmTskxoIDCbBwGe3h8SY1ZQjbkgtSinJ5x5i1f6Geuhwzib4A+1FrKKpJ+EOnCGLYwPEQs47eoGOnlwYkYg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772370907; c=relaxed/simple;
	bh=9Q0MBbu0y1LVil5sshcFZ8oCt7xdopWfBZiQtl5H8sI=;
	h=Content-Type:Date:Message-Id:Cc:Subject:From:To:References:
	 In-Reply-To:MIME-Version; b=BFFW/f2PqpmqTw5SAY0ARJ81Hc1jZylqFw2S+6HmP3OOnxyAYiMC654wrjYYMdTL2vnX/760DI3PkZKKZivN3cFftTx/4f2uyh03XhyfAWUIfFqKynBjU6xSCTOn181Lm8gBexT0LVsJKSZLHYnOJSXmZHtaVu2ymKSXLWx9EZ4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=garyguo.net; spf=pass smtp.mailfrom=garyguo.net; dkim=pass (1024-bit key) header.d=garyguo.net header.i=@garyguo.net header.b=nYo0dgOA; arc=fail smtp.client-ip=52.101.196.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=garyguo.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=garyguo.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=garyguo.net header.i=@garyguo.net header.b="nYo0dgOA"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=pq/IoH05SByyvpFXFsD9orw/V4svn0Ua2JPR9e3Ljf0ZIf/Q2ehtzTih2PKfJKz1nwJs3ITDwGukgLMNhWr7v7h5nc5q35Nq3Tjl/1IvFWwH92Eurx2JEdDMnxd8//EzfSKaq1OumU6TSdPk2BSjm5f91wHTK5JvD6t/fLI02aHgsFueSBLqzQhnHu1tghJUCBVCSETAoPnaH9sU6EjWacYynAJrgr6G8fMc1nTazqyMYXTcw8urYoFFz9Ep/RHNZxYHq9AtKyZmploIv8JK3WlI2BBIZwbAqxTo713oOWfeYZk03MA3ZcH/isxLQcIncyn6efWwN5UGo/K3pAc8hw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9Q0MBbu0y1LVil5sshcFZ8oCt7xdopWfBZiQtl5H8sI=;
 b=n4fd38F9UGhpGfje/gyiImbFzuRtSywdc3y4mbCSQFXQgXnIkUxGVgTuXHjTGyFQmSI/6v0kpC7iuuKgMjAX5s7j5oPzyyCjqtzA6ZfTl1+DnuQykEA9WFLB1c5fztWmYFJXyxp6fk/x+1nsFiy+uoDM3VnAVgf/XWVD6aIF+XPpGeBsbvvvuppB8ePTcF3+M4UNoEc3Eias8Bj/rDoXAoQly9z+hHExP17xe7SsNfl7mkadk9fPWf4fpcbzqrOXqMwAHVOg9+GdCzBcBTLAC2yM8DzFQZb595yA1Jk9wvhETrB7g+niA6m73Ol2syvJJ7ia6wUIhz+/N4MPXaQ4VA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=garyguo.net; dmarc=pass action=none header.from=garyguo.net;
 dkim=pass header.d=garyguo.net; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=garyguo.net;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9Q0MBbu0y1LVil5sshcFZ8oCt7xdopWfBZiQtl5H8sI=;
 b=nYo0dgOASXOcx5ec6mIANNvmrxyqPaEshHtMvEIVrIIRvLuYR6hzxWIkOzTo6bi33o15nz20+kUN8WuaPr0RLTlR7HYhYcOeo18RLjUCvz5DyWblJj9OI4oNrmU3D6+UDuymUZOYCtmJ8IW/q/zbR4QWQZmUozR2DGpVcK5JSds=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=garyguo.net;
Received: from LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM (2603:10a6:600:488::16)
 by CW1P265MB7840.GBRP265.PROD.OUTLOOK.COM (2603:10a6:400:213::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9654.19; Sun, 1 Mar
 2026 13:15:01 +0000
Received: from LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM
 ([fe80::1c3:ceba:21b4:9986]) by LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM
 ([fe80::1c3:ceba:21b4:9986%5]) with mapi id 15.20.9654.015; Sun, 1 Mar 2026
 13:15:01 +0000
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Sun, 01 Mar 2026 13:15:00 +0000
Message-Id: <DGRH1R6GVNI7.11AU3CRM3M36Y@garyguo.net>
Cc: <linux-kernel@vger.kernel.org>, "Miguel Ojeda" <ojeda@kernel.org>,
 "Boqun Feng" <boqun@kernel.org>, "Bjorn Roy Baron"
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
 <corbet@lwn.net>, "Alex Deucher" <alexander.deucher@amd.com>, "Christian
 Koenig" <christian.koenig@amd.com>, "Jani Nikula"
 <jani.nikula@linux.intel.com>, "Joonas Lahtinen"
 <joonas.lahtinen@linux.intel.com>, "Vivi Rodrigo" <rodrigo.vivi@intel.com>,
 "Tvrtko Ursulin" <tursulin@ursulin.net>, "Rui Huang" <ray.huang@amd.com>,
 "Matthew Auld" <matthew.auld@intel.com>, "Matthew Brost"
 <matthew.brost@intel.com>, "Lucas De Marchi" <lucas.demarchi@intel.com>,
 "Thomas Hellstrom" <thomas.hellstrom@linux.intel.com>, "Helge Deller"
 <deller@gmx.de>, "Alex Gaynor" <alex.gaynor@gmail.com>, "Boqun Feng"
 <boqun.feng@gmail.com>, "John Hubbard" <jhubbard@nvidia.com>, "Alistair
 Popple" <apopple@nvidia.com>, "Timur Tabi" <ttabi@nvidia.com>, "Edwin Peer"
 <epeer@nvidia.com>, "Alexandre Courbot" <acourbot@nvidia.com>, "Andrea
 Righi" <arighi@nvidia.com>, "Andy Ritger" <aritger@nvidia.com>, "Zhi Wang"
 <zhiw@nvidia.com>, "Balbir Singh" <balbirs@nvidia.com>, "Philipp Stanner"
 <phasta@kernel.org>, "Elle Rhumsaa" <elle@weathered-steel.dev>,
 <alexeyi@nvidia.com>, "Eliot Courtney" <ecourtney@nvidia.com>,
 <joel@joelfernandes.org>, <linux-doc@vger.kernel.org>,
 <amd-gfx@lists.freedesktop.org>, <intel-gfx@lists.freedesktop.org>,
 <intel-xe@lists.freedesktop.org>, <linux-fbdev@vger.kernel.org>
Subject: Re: [PATCH v8 16/25] gpu: nova-core: mm: Add page table walker for
 MMU v2/v3
From: "Gary Guo" <gary@garyguo.net>
To: "Joel Fernandes" <joelagnelf@nvidia.com>, "Gary Guo" <gary@garyguo.net>
X-Mailer: aerc 0.21.0
References: <129e9988ff8d3e8747f724fbcc88c5cb@garyguo.net>
 <1772028959.538096.8539@nvidia.com>
In-Reply-To: <1772028959.538096.8539@nvidia.com>
X-ClientProxiedBy: LO4P265CA0205.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:318::19) To LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:488::16)
Precedence: bulk
X-Mailing-List: linux-fbdev@vger.kernel.org
List-Id: <linux-fbdev.vger.kernel.org>
List-Subscribe: <mailto:linux-fbdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fbdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LOVP265MB8871:EE_|CW1P265MB7840:EE_
X-MS-Office365-Filtering-Correlation-Id: 88820731-2f90-4056-d564-08de77948b72
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|10070799003|1800799024|366016;
X-Microsoft-Antispam-Message-Info:
	3N4cZL77euMcSCAvU7e/RnZkc2p7Hu0kc1cWqYSU/spG9kKlf8U0+UlaI5Q4hwwikDeadrnYphqxsAsp7JzQVDfd3b3o71PPYwHLXVDUgGe8P8lNLzSqRuoIWi8O9C9lYE8USVtAIwlxbcG1c4YJPtaiJJPdNE9MufioeZE0+a3XQa0PNwV964HgPWa46EVmHf3qF8sqtN7OqINvmsK2uiI8DjdrVyTRLSJ5YzimE/rB9aCS9Op+V8a7PVZegP864XT71CSuTIAWGrWejlq1uvAJtPXTzPjoGeFyp64ShWMgNxc5PCf9U6Z1NG3r+YwJapibcwl28mPNjDxXjbbjqo1vCJc5WK8eSTC6UHBjBE+PnI/VMlHX0GBuYKwLAqTegf658xyhQS2fhAelpW1jykXLH56XehK3jNa/gQ96IRpSfiQT1JOryUl/TEsZsITlrMR614udSaDuf4Q1bGmQSQCn2q4DlkZyKBCHWKK0UGlRPzSQEtrOPb9tCJk/RbZY/MjTNIDg0guhejM9iJ9PqVLSW6TfyjwfHFsTE4dusdHjy6MBaCT/krpE6P462x17f66zXH4feV03wo8xDiShwZk+EXGWVtnPD3bIJlPHTqZ4+76YEcsCDlX9jEteTIB0PsQ2OudImNpVj1UW68iG1ne3k9MAifC9cpAYQ61s5Qi8iV53GcPoxW5ftwhiqk71QJCtrpzW/KR8NH/0Cd+Il0XdZrAu17hA/MLCi/HBuCo=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(10070799003)(1800799024)(366016);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?OFk4UFNsOHp0TXZwaXZKUWhlTS93MnRTM0dnbEVSTzNSdnZVbVNxVnRtOWdM?=
 =?utf-8?B?b1E2MGJtb20wOHlJYzR5QXB5bTlIQ1pJRERBRTBSQStJeGJHdHliM242SmZD?=
 =?utf-8?B?MTJMcyttYUZtd1dhZmQ5eUNMK0xwZk5XM2I3cHAwUzFNUy9BM3l3bk9vY21E?=
 =?utf-8?B?NExmZXBPdWMwV2RrSE4xbHBCMXQ3Y2o5aTc0ZEtnaVFlSkN4THBveC8rZ3N1?=
 =?utf-8?B?d2ZyaXJUek1Od0xrSGVmdzFSMzBsSTkwRUl5UDV6bGgvb3VYbkRDcS9lRmlS?=
 =?utf-8?B?UmlXcjNwdk5CanV0VDFRRXcrQlhGaXpTN2IzRkozb2FDSm1seCtoU2ptY09J?=
 =?utf-8?B?RkgxZE1rdXFKTGN0YUZiTnZyVDBQUngwQmFtTEZjZSs5N0t3MzVQTzFIWWZh?=
 =?utf-8?B?aVdzaW5scWtDWlU0cjhDT1gvYTlpSEc1MVlQQkNnSWt4VkhnQkNBSTBEK1Z5?=
 =?utf-8?B?WkJFc0J4d3RaVytnTlF0YmREeC9YbFJlZnB1MFR3K0ZHWldkYjFDREUzaHZT?=
 =?utf-8?B?TjgrRVVRdDJXZXNJSUIwOEdEbjBkUkdaVklva0hrcmdwdWdkYWxmSEZ1QUZG?=
 =?utf-8?B?bE5JQUM5clJCQVBPMFYxdFQvL25qQWUrMEdKYnhCT084dlJybHFiMC8yQlpW?=
 =?utf-8?B?L0djcHlwT3ppVEh4ZTVKRVFFelJTcTRKZTBUUEdzanZ4UXI3MUdpL0l2Qzcw?=
 =?utf-8?B?UGY1UC8rRnFWV0VwR2ZERlhVb2s2T25IMHJKQnkvOEZFVVYvdWFjQWNFYy9n?=
 =?utf-8?B?TlZud01lL21LM3BESStsc0FydHoxZ1k4WjVwVmg0VG51NFJhemZXa0ZXNDlo?=
 =?utf-8?B?R21xVFM5R3kzT3d5cXRVM21sTFpPY0FaRVNFT2Z1RlRSbWE2ajljVFR4WnY4?=
 =?utf-8?B?aUJNUStaMVJpNHF4Y2hFakFRd0YvNVl4QXFkajZBOVY0TUxDQmxDVktpbjZn?=
 =?utf-8?B?YjRPWGFUYi9vdy9lUlVKdUpucVdNZUltSE41SnVVc2VhNE82amNQaWNTUXlN?=
 =?utf-8?B?eG1XMVBoZklrOUovdHNVNUYzcERiYUFCdGUvM08zL09EMXV4VzdoVWFqUmVW?=
 =?utf-8?B?STdBaHBrQVZqL1EraldDUGRic2VJenY5bWp2RFdEVXlweWJlWHp2OXJLbWZx?=
 =?utf-8?B?NU5sMVZpMzdSR2RCUzdJK2FtamErSlBkRUs2OTU5SnZKZFExVU5jaS9QbVJJ?=
 =?utf-8?B?OVNHb0oxWkFNZWxtanhXMmpsVEdaVmpxQTdQY2YrVGROcUdLaHYwYjk2SVMy?=
 =?utf-8?B?ZVp1b1FTYzBYcUFqdnV3SDZiRHJJYjNlOUJVVVZaaUYzQUtyVk5PVm5GRGo3?=
 =?utf-8?B?bEt1UGluZ25DWWF2d2RLWFcwMGZ1M01QSHJlTXVsNUxNYkJoL1l0RG9tZUNa?=
 =?utf-8?B?ZEw2K2VzTzFQOTV0MVovMGJxM25QYjNDTlN2aEd2MFlzVGNVYldEWXRWdVRS?=
 =?utf-8?B?Y0pOcjIxTUNmZ3VjeVVUVFAyVWxYVUliY3RualEvRjBsMmhFV29OL25OVGRG?=
 =?utf-8?B?WmxsL25ENkFkbXUvRHVHZ09MZlMxVUtDSGVIdURCMkt2dEp1UVNuTnJEL2xL?=
 =?utf-8?B?WHVUR0lOUngzUjB4eVBDckFuOEJYT2JQYk5GMzFvMlV2ZEl1U0FRRDJvZFYv?=
 =?utf-8?B?YWNLd29WaDhJcG5SQjVzd3Jlb1ppcWEybHoyczIrMUtXWmQ2Z2FmRXptUEFQ?=
 =?utf-8?B?Wnhad3YvR1pDdUpmMlEyK1NtOEJiQnZSUDdpckxramZTTHBTNmR3S0hGQ3Y1?=
 =?utf-8?B?YXNmcWFOYXV1UlBtWk9CUVdCYitYUjk1RDVSK3VqV3hLcGJLVDZIYnMrMktW?=
 =?utf-8?B?VHVRcUpPQSs5S2RxRm90Uzh4d0lXUHdDZXhUcGQvVndGRytNckFKbGZublV4?=
 =?utf-8?B?STFRVldwai9UV1N6MUVIZEU2b2doUGFZMkhYdVhROURvTjQ0MkYvdDFjSGJF?=
 =?utf-8?B?WmxRVkZ5dkZTRFc4UWxBanVrcUxwOC9udXBxZUJhMzJncFNKay9qZmxNY3ZL?=
 =?utf-8?B?UHNXUXlobmozNkU0Vk1OZE5taVhBclNFeHNheERRZitQdXM3Y1c2eUVYdGJ3?=
 =?utf-8?B?RnczK0VNK0cvZnRLcFpjWVFaZDFDUngxSVlQaXlLNS9yT1p6MUFNUm51R0o3?=
 =?utf-8?B?TW8vQ1h0Wm12UzFFUDJ6UWZxK3FpOUdhY0FSNXJPN2RQVUFncEZhazh6ZUVQ?=
 =?utf-8?B?ajl2bk13aGtabkxuY3pWRjNyN1lkZWNWT1A1RVhvZkI1RDl5N1ZZUDJMQUFU?=
 =?utf-8?B?cklFQjNRM2V3TlpqUzhFVkdMVURMRW5jVzJvZnJWb1NsbjRhb1dja2Z5aVRV?=
 =?utf-8?B?TXFLYUFSTW52ZWVWR0FpTnFuVlp5M2Uvc2F5dnN5dHdOTFozMjBXQT09?=
X-OriginatorOrg: garyguo.net
X-MS-Exchange-CrossTenant-Network-Message-Id: 88820731-2f90-4056-d564-08de77948b72
X-MS-Exchange-CrossTenant-AuthSource: LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Mar 2026 13:15:01.2737
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bbc898ad-b10f-4e10-8552-d9377b823d45
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: pcePeY1DiB65xdeoFXvV5ZAODiTa/38O1WZlXHwJY6c9HSxQz3K3NjCgU7OrAJg6TZgNmjkiOh0XaAGofQq3sA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CW1P265MB7840

On Wed Feb 25, 2026 at 2:26 PM GMT, Joel Fernandes wrote:
> On 2026-02-25, Gary Guo <gary@garyguo.net> wrote:
>> On 2026-02-24 22:53, Joel Fernandes wrote:
>>> +//! ## MMU v2 (Turing/Ampere/Ada) - 5 levels
>>> [...]
>>> +//! ## MMU v3 (Hopper+) - 6 levels
>>
>> I think this is called "4 levels" and "5 levels" in kernel MM rather tha=
n
>> "5 levels" and "6 levels".
>
> Actually, I think "5 levels" and "6 levels" is correct even by x86 kernel=
 MM
> convention. In x86 "4-level paging", the 4 levels are PGD, PUD, PMD, PTE =
-
> the root page directory (PGD) IS counted as one of the 4 levels. Similarl=
y,
> for the GPU MMU, counting the root PDB (L0) as a level gives us 5 levels =
for
> v2 (PDB/L0 through L4/PTE) and 6 levels for v3 (PDB/L0 through L5/PTE).
>
> This is also consistent with NVIDIA's own hardware definitions in the Ope=
nRM
> headers (dev_mmu.h for Turing and Hopper) which define the page table ent=
ries
> for each of these levels. The virtual address bitfield spans L0 (bits 56:=
48)
> through L4 (bits 20:12) for v2, giving 5 distinct page table levels.
>
> FWIW, the existing nouveau driver also uses this convention - NVKM_VMM_LE=
VELS_MAX
> is defined as 6 in nvkm/subdev/mmu/vmm.c, and the GH100 page table descri=
ptors
> in vmmgh100.c list all 6 levels.

So PDB is not just a single address, but a list of page table entries? If t=
hat's
the case, then the number of levels is indeed correct, but reading the code
gives me an impression otherwise.

Best,
Gary
