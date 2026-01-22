Received: from PH7PR06CU001.outbound.protection.outlook.com (mail-westus3azon11010048.outbound.protection.outlook.com [52.101.201.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C3B573D9F51;
	Thu, 22 Jan 2026 23:16:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.201.48
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769123779; cv=fail; b=TrWK5Eyvl7DfEzagmsKUR1mpghbxILHEOYmaVQ4qtLiNw3rO0mTf901xubXJqyf4d6EWlMnxBsbmma16SPqu4YOcOANnzRnQzCalnw3akTevEfWREg0DOLFf2BzsuQ5aXP3+W/vz5tfZOJJmbJTucvDArS9Q3FMYTsqfiL7ndzw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769123779; c=relaxed/simple;
	bh=uZOBtFXv6ziPbeLmlIfSgG+Jf03ZKRHjQZpsBvvdnVE=;
	h=Date:From:To:CC:Subject:In-Reply-To:References:Content-Type:
	 Message-ID:MIME-Version; b=LdF6b70sBz6OpY/17MlEl5GGLikR7OO/r29hYicoCDbvq5VEqAspV8odAJctuCda02yrP20MtvOVffAYnuZUEYxLd6kpwvsiU5B/d85Jn/r+lcJ0ESt3FhilkEXYAMd09M/Wr5sJv5wwCY3353wKiPXKkrIIhA/uvpmOcxQ/NTc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=WMYLPPbi; arc=fail smtp.client-ip=52.101.201.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="WMYLPPbi"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=w2lXqICs2IwDORKYKdRW5BP0QPmxRGa54PjWlDwEU3mYun0qzgnma3vMaWH7FDPyTaEqqlypAo6pm68scCbiJr7M9qOSCbn32qdz+D2bxMc2sWQYt089qXgbxCFc3KItF1sWE1KquwabDQCpniSXHSDPjTVu+zD+xjBSuXBKBUYyhek7pnMgy8OZMPnCuN6eg1K5JrE3HyeYjwvTbi11zBEHnRmzZjxaXrVUPVo3B/J0TGhdynD6TS6e8Bfjoscc7PMkt1AwOgz7o998u8NNABPjlW+HlSRmnjXwpssN5XQ5xgzrRnXKajgkC9blyfrsjYcLwlnvm6uBYHx98aa7FA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=J2eoQnmbX0KU6kPkKMUo8MyINdUZrtvd7/1Gw9IN6aQ=;
 b=nQ/9vnwxS/2TPEZkdzPmlptQxg+UP6ZkP0glYD9FAC+W/CeEJ+hAQaO6aGy/a0/2erpstqqnRAIXSuYqr1vyw3mpiqEmwPOC3shnI3mACHxPCWWSYdYGVBMM+PbGwl6RGtd/dN1o4Q3PwWZD2IQbX5jEOlxIfvmyXvFU6SvY0GqfWEeYJOI5X0S5mXYaFlGbRbnOza3GnmK9J7uX0YNGLTC9BB27AM1bEmkLFU1+yIyzbEyENiDMNG3kfr2i6P4nqG/gMtIlTJ4QigrOYc+KaxxPM1mhgYqVvww1u1hysGO3F9uhaTG11uGd4lR/U2DDzhSvcuNxNjqp9D5uMInetA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=J2eoQnmbX0KU6kPkKMUo8MyINdUZrtvd7/1Gw9IN6aQ=;
 b=WMYLPPbiE7KuV32iiCEgligwdjpnS//d6KiVKbJmWHGGPPsfK5f5WyNbfaE9AINQBWVr4u98lCcss8Dg5HA7HaApseTT0y+IdO27320rrD+zqKxNdqdOaCP37SHpzKfwT1e6d6v5e01xLxfmqx/65uGqWiLKki5XF0Sk55DA78ouHvvSN1hd987zoqcKTtOMuM9qB0HkQRcQ1X9shMMU+KbKz7NPv331UvKYytccOUvcEUoCZS6/g2FANSVrRj5XtT6h0UM3f8zs03vg3c26ZTXlSq8txOGmypGI1Bw5MqmzNoYtJcf3ZRbOyik8gkFH7ULua2o7n2zeaB+W2BzbGg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DS0PR12MB6486.namprd12.prod.outlook.com (2603:10b6:8:c5::21) by
 PH0PR12MB8097.namprd12.prod.outlook.com (2603:10b6:510:295::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9542.10; Thu, 22 Jan
 2026 23:16:02 +0000
Received: from DS0PR12MB6486.namprd12.prod.outlook.com
 ([fe80::88a9:f314:c95f:8b33]) by DS0PR12MB6486.namprd12.prod.outlook.com
 ([fe80::88a9:f314:c95f:8b33%4]) with mapi id 15.20.9542.008; Thu, 22 Jan 2026
 23:16:01 +0000
Date: Thu, 22 Jan 2026 18:16:00 -0500
From: Joel Fernandes <joelagnelf@nvidia.com>
To: Zhi Wang <zhiw@nvidia.com>
CC: linux-kernel@vger.kernel.org,
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Maxime Ripard <mripard@kernel.org>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	David Airlie <airlied@gmail.com>,
	Simona Vetter <simona@ffwll.ch>,
	Jonathan Corbet <corbet@lwn.net>,
	Alex Deucher <alexander.deucher@amd.com>,
	Christian Koenig <christian.koenig@amd.com>,
	Jani Nikula <jani.nikula@linux.intel.com>,
	Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
	Rodrigo Vivi <rodrigo.vivi@intel.com>,
	Tvrtko Ursulin <tursulin@ursulin.net>,
	Huang Rui <ray.huang@amd.com>,
	Matthew Auld <matthew.auld@intel.com>,
	Matthew Brost <matthew.brost@intel.com>,
	Lucas De Marchi <lucas.demarchi@intel.com>,
	Thomas Hellstrom <thomas.hellstrom@linux.intel.com>,
	Helge Deller <deller@gmx.de>,
	Danilo Krummrich <dakr@kernel.org>,
	Alice Ryhl <aliceryhl@google.com>,
	Miguel Ojeda <ojeda@kernel.org>,
	Alex Gaynor <alex.gaynor@gmail.com>,
	Boqun Feng <boqun.feng@gmail.com>,
	Gary Guo <gary@garyguo.net>,
	Bjorn Roy Baron <bjorn3_gh@protonmail.com>,
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
	Alexey Ivanov <alexeyi@nvidia.com>,
	Balbir Singh <balbirs@nvidia.com>,
	Philipp Stanner <phasta@kernel.org>,
	Elle Rhumsaa <elle@weathered-steel.dev>,
	Daniel Almeida <daniel.almeida@collabora.com>,
	nouveau@lists.freedesktop.org,
	dri-devel@lists.freedesktop.org,
	rust-for-linux@vger.kernel.org,
	linux-doc@vger.kernel.org,
	amd-gfx@lists.freedesktop.org,
	intel-gfx@lists.freedesktop.org,
	intel-xe@lists.freedesktop.org,
	linux-fbdev@vger.kernel.org
Subject: Re: [PATCH RFC v6 05/26] nova-core: mm: Add support to use PRAMIN windows to write to VRAM
In-Reply-To: <e186973c-ce31-405a-8bfa-dc647737a666@nvidia.com>
References: <20260120204303.3229303-1-joelagnelf@nvidia.com>
	<20260120204303.3229303-6-joelagnelf@nvidia.com>
	<20260121100745.2b5a58e5.zhiw@nvidia.com>
	<e186973c-ce31-405a-8bfa-dc647737a666@nvidia.com>
Content-Type: text/plain; charset="utf-8"
X-ClientProxiedBy: BL1PR13CA0341.namprd13.prod.outlook.com
 (2603:10b6:208:2c6::16) To DS0PR12MB6486.namprd12.prod.outlook.com
 (2603:10b6:8:c5::21)
Message-ID:
 <DS0PR12MB6486717785F6DD14EE1F1C46A397A@DS0PR12MB6486.namprd12.prod.outlook.com>
Precedence: bulk
X-Mailing-List: linux-fbdev@vger.kernel.org
List-Id: <linux-fbdev.vger.kernel.org>
List-Subscribe: <mailto:linux-fbdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fbdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR12MB6486:EE_|PH0PR12MB8097:EE_
X-MS-Office365-Filtering-Correlation-Id: 48d30beb-fbf7-404b-c347-08de5a0c3564
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?NFVPeXRQZHRqVWQ3MkNSSWM4SGZBUE5ialZHblR0WGlNc2x0MDQ4OHdwcUZQ?=
 =?utf-8?B?b3dVU3NnL3pmM2xvMjVRT2RBTkhNZW9SV2Q1VmVqeVFuaFNNQlBqV1J3SDZt?=
 =?utf-8?B?MW9BS2krbDd2NGtIVlI4WDZCWUQ5UEorcElhOCtsRlZnckNSRmtoVEZiQ0NH?=
 =?utf-8?B?S2h5c3I3d1NKVDAxMytSYjJaamZpd1ZpREYzY1BpWjNCTUREd3ZBdUk5RUxM?=
 =?utf-8?B?UmNlRWRiNzdrM05iUFZPQnc3YTBHa2ZZSWQwVlVqZ2p0WktFdzZ1b0V4Uzl0?=
 =?utf-8?B?WTlVUmV3NjFYMFo4L0EvY2pTOUpwZURTVDY5Vlh3alRPSGxjS3VQQjBxZVdx?=
 =?utf-8?B?dHJ3Yk1kbXdXdkRLS0sxZTdLR0p4SFUzMnM0dVQ3bXB0VjJkNFhHR3o4RFFJ?=
 =?utf-8?B?TkRXeS9neFVHRXRzWGJqME81amVSY0xsU01rNlI5VjhMNUVmYkxmbDJzT1pJ?=
 =?utf-8?B?aWEwa3NUS0ZDNEdsN1FwQ2VoWU8wL1M4R3cwdnQ3U29XQ2FJekZXaVAybEtT?=
 =?utf-8?B?dTFEa0RPSG1WVVYrSnh3MytSMGRLZjhDZS84T1dEbGpKWFhRZ0RhYVpUTVVh?=
 =?utf-8?B?amhHVVNtRUtHWmxOTTRxK3VwN0xCMlVJV0JrWHRVS1Q5Ri9KS2dobFlYdXFU?=
 =?utf-8?B?Snh5eDU2UGliY25Na2tqak5UTzdIeTNFRWtVVFZMYWdDZWVneGJVblJPWnE3?=
 =?utf-8?B?Smp3MkdwRGtuVVdocndsL3FKZVBaMGo5RFhPTU1RaUdhZDl5VzhvMkgrSzl0?=
 =?utf-8?B?ZmpTM1IvZTFqWmtKVVNEaWlITUFYMzNVOXNiYkZWY2tUV3NpMTRqamJMdVd0?=
 =?utf-8?B?dmRQaklVMVZXdkZyMWwrUGhjZWhzdklKTDc4RnlrazlQYTJGWVB3N21ZdjNX?=
 =?utf-8?B?M1BXYlJ6amhzR0NtUzc4YllTS05ySjZ2L2xMaDhjR0hTRmxUZDFpazlvb2FC?=
 =?utf-8?B?a2RRUmxKUXdId1BEVVM5cmJ6WnVqSWMwTFFOeUtVQ0xuNUxXcXlsMHdrUlAy?=
 =?utf-8?B?dVFBTzlsNFJxRFdHeWRBVnI5aDZaT2tyVVdDbkJhUEdUSFhtZ2E0YmFZOG50?=
 =?utf-8?B?OVlMczNtemxTVUVoZ0VwNXhWc0FLc1ZmejZYa3U1TFFEVVl5ZXpwTFlJTENW?=
 =?utf-8?B?a2xsY2VLenFGYUJmYTVzdmdobkJ1eUVmTW92cXFtQUh3ajk3dGVwVkUrdU9r?=
 =?utf-8?B?LzMxYmNSaklHVnJqSXhteTJkcE5ySyszbFI4Q0MzYWoyeTR0Rlp6OEN0Ukhi?=
 =?utf-8?B?Z3RMRnA3K0J2TWZrd3F0ZU5uMkdCTnkwNDVyeVYvcDQ0SWRONW90SWRRRnVS?=
 =?utf-8?B?WmwxYVJQdFhuK001TGtYWSttVzlLT0Q5K2NFVVAxTHUyUnR0c3RtOFBBTDdD?=
 =?utf-8?B?WWR5aSttMW5CTjRKZ2VxRkdRTFlRbVN3S1hmMVRhUzNCaTExeUNaUDlyTThF?=
 =?utf-8?B?a1htV2h0KzVrQXcvNmlwbVpWU1gzZjAyelRKeXZ1enJtNjdaMlRqM0pOdTB0?=
 =?utf-8?B?d09Cb1Q0cGIzTXM0ZnY2ZFJibnJnVmlxRFpXeGludXI1aC8yeWtuRmwxYTg0?=
 =?utf-8?B?YmJvbWRYK3ZKNHk5bWJqb21HQlM4RVROQ09IQlcyYkkxWm1JbHBZeEY2bk5Z?=
 =?utf-8?B?a1ArN2k1bHdNMjdEUGFaODI1TkM4eDl6NTd3NUtybDhHODdVOWFjc1UxS2Uy?=
 =?utf-8?B?ZmdRS3pQRWswWVJzNHpROFNjYkh4NExETC9yaXNaYkJMeWFwZHV2bmtvZ0tp?=
 =?utf-8?B?MVlCaWZMWGc4dml2TnhsUjlTNVNaZ3FvTXhKRUJ1U1Blc25va1E1UHBPZzdC?=
 =?utf-8?B?Q2hobEhnTGZ4OWRkVnBpQWlZNmtKMFpKaHFGcGt1VXlKaStTQVpQWUJIaWw3?=
 =?utf-8?B?ZzBRdno4TmNxcmVZejVYQTRORU1obmVJYkdHMU1jLzlWTlp3a2FuSWxma2Iy?=
 =?utf-8?B?SXBiUmF5dmRsUTM2ZExsa3czYURUTHpUdHRFNjVUdzRUbTd5WlpQNzhQbUtm?=
 =?utf-8?B?QTNHQ3h4ZExIQmJlUzVsVGVPdmozVmxRT2JHUWg5K2NmSExSYlZjWHc5ZXZW?=
 =?utf-8?B?ZkhBeXB1TW1CUkdJNUxPWlN3TkF4eHJhKzlqUHVBNEdWS2hOYTFqcjNyQ0JC?=
 =?utf-8?Q?GPvU=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR12MB6486.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?a3loMm5GcXltR0pCaWp4ekRFa2IzZUZmSGFnd3J5SkF0aFZPNEpkR1V0U0JK?=
 =?utf-8?B?SUhDZlBqWUZhcVp1Q3ZleFd5YnEveVpoU2pGbU9XTjlyK3k4Mjg0ck1NamJr?=
 =?utf-8?B?MEU4U2hFbFVvRGlKekRDd1phSG9hTUpoREsxVEZESmRXK3U3SjBRK1dJMkc1?=
 =?utf-8?B?eE0yVS9pSjYzdFJ2QUNpNVJWVDZ5Y1kwcTcxQU96SGxockpVTnBQOUtNcHBW?=
 =?utf-8?B?MU1uQTRMWkZ2NTBlajBXRExhVDl4eXJ1QUVjMXoxQXh4QkliazZCbmpiL29O?=
 =?utf-8?B?TnZzSW03WHJ6d2RMeDVyUS9xMUlXZERnMmN6eFVPdnhPZS9VZ1Q5V3hTYWkz?=
 =?utf-8?B?WHVqYnRGb2FXdkJZVGU4dHpIMnZ3a3AydmxsVXNyN3Q5VlkxTXA5dHlhckll?=
 =?utf-8?B?T3JUaS8zM1IwM3o4QW1EMVlOMHhZVHNBYUpEdTdaam5UQ3JSVDc0dW1TcHdj?=
 =?utf-8?B?MWdxY0JQaEVWZzVhdThrRzBPRmp4WldoU05EUllzdjBmVnZkT1JCeTJMV1Qx?=
 =?utf-8?B?L29ydDUzb0JKSUpMRys3T1hpMjc4N3pUbHRZcFVrVVI4M1c1eWlaQjJnRzh3?=
 =?utf-8?B?TUVJVWhPQzd0VXJBVzBHdGlQVm56eGtCMTArZGlJTjNjRmpSS2czUkpHVmR3?=
 =?utf-8?B?TSt2aGowdE9PNFZsbkl6ck5Pd3llb0NSRnVGQXN6TG5XMWNoQUN6YURJZkFC?=
 =?utf-8?B?ZlZCYWN0MTJ3cmxpYW0rd2pXdnpJdERSRkxWNHNqcXpCNzU2QUdHSlAwMzZM?=
 =?utf-8?B?bHZFM2ZsbFBtSVFZUStKaGMxcGhOT2pSbm1UK0ZCNTRsbm9pUjVMZm03Zmlp?=
 =?utf-8?B?Tjl5QVI4dWg4bCtDSTNLYWU4bnpyY3dQYkNNWmJ0MHVqVldWSGoyR0tDZldv?=
 =?utf-8?B?NGFldThrVmpleFlkU3pQNE5tV0RnakZzSFJYenlKK0dObEJsbGhaNXpNWjR2?=
 =?utf-8?B?VjNqSDZCTG9ENzBPYTJMdDQ3aFB4bjhJNklvNTIyanlCbEh2NlJvMlhNbU5t?=
 =?utf-8?B?dFYxN0tsaEUxUCsxSlh6STFsbWdTa2VPTFNzdUp0RCtwNzhYUnltc0hFVU5T?=
 =?utf-8?B?SjZPUG9tVGdHNnZuNy9sM2Z6YmNZMEt4VStxY1hucFF0RllKRCtYTzUzN1A2?=
 =?utf-8?B?c1ZRSFp4Tk5USTVKcjdmNnpDb29yQ0RRVzUzUVZVQ1pCMFVkK2ZHSHRtUFVq?=
 =?utf-8?B?bXBGb1FsNDVMMmhJVm9rRUtIajJmU1JhRkFLeHc3bmJuNThzYzY5ZXNEd1Bm?=
 =?utf-8?B?dDBGa3VDTzJWVGR1SjhwdjlkQjdOdzNMSEJMSkJ6eUh5Tm8rZUphRW5YTFVh?=
 =?utf-8?B?SFo3RVlMOG1jMmpMb2dGMmRTcDZpdGlpQ3lpOTBESGNJSzc1em96Q1RGMXdU?=
 =?utf-8?B?TlpJb3lTVDdsemozV0tQeEZXVTZoMGxneWh0dlVncjVEcmJDNXBtcUJnVjNv?=
 =?utf-8?B?QWRxMEx5L01nMSt6bWVGSCsra05qS1RlRHFNRHpoR2xaaHZXei9ocFJvQ1BV?=
 =?utf-8?B?M3lGM2lZb1JhcUlQYnZiQTFlMWVpR2VlRDZkaW9RRmxaL2cvK3ZhQnZMOXp2?=
 =?utf-8?B?WkxMSXFkNTRUbVlwbHo0SFl2clkzOXNCZm5qb1RvTVdEUHkrQnBiWU1OSXFl?=
 =?utf-8?B?aTJXRER6S2pXNWh1ZUpVYzJsN1lxSGlNZkswSG5lZTdxSHJzN3RUaC83R2xD?=
 =?utf-8?B?T3NoZjVlUTZla1pPRzZESUVqTTVvc2orRXF5d1FrOGVaTmVHK3BrTXErNDA5?=
 =?utf-8?B?b1VGNytOQSsrRVp0Y1daNTl1NWk0dGd0M3ZZUWZwMW42bkNsOHJQMm5ZbEJx?=
 =?utf-8?B?dldZQ2tQWHB6aWVEVWR2ajl0K1Ria0ZSWm9VYUtGeVVTREhyMDIrSE9qY3hp?=
 =?utf-8?B?bmRGaCt6anBGSUVEOW5GVndUWXgyaGRmQm83MmtDT016SDNId045dGlsKzZP?=
 =?utf-8?B?NFRvTVB2NnZrT0tSSnN3bWdpWDZ0QWduTlEzTGFLWUdzUkx3V0h1WEg0T3Nk?=
 =?utf-8?B?UnJOaXBDTGVWZUFaSERRYWdrMGltaWdONExtcHhBaG1PR2E3NVRIVUlFaXc4?=
 =?utf-8?B?OU9yRDVjUWlNZVBvWkFKS1dGV0ZiejlQZjBjNVhnVW92SkttUEhDTzlWazAv?=
 =?utf-8?B?ZmhtMC82Ynl6N01MWjByYkM2eC80S2hyNnRES2RpaW51ZlZaMi9wYmhhYkRR?=
 =?utf-8?B?VVFsWkxteE5pNXU0NzNYcG4rTGhyd3pqcjV0UXdFYUhiVUlnZjJ5cEs0ejl0?=
 =?utf-8?B?T1RzZ0F1bWRuNXdoOEhnc3Rnb1RNYkcwNzFVczZjOHhRWU14YmtGRkRiczdE?=
 =?utf-8?B?U0NyNVJyYzAyc2VJRUY1bVlnMDVrVzRXaWpNY1poNEc5Rm1Pb3J3Zz09?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 48d30beb-fbf7-404b-c347-08de5a0c3564
X-MS-Exchange-CrossTenant-AuthSource: DS0PR12MB6486.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Jan 2026 23:16:01.7499
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: S4J/1D+qJqJEo1DbyMEpyZZSU0LtVL0nSCNYlQZhM1TnFb1y92zPFPN18CqEqGh0iqanZU+uvDMWb/O3zDDXGg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR12MB8097

On Wed, 21 Jan 2026 12:52:10 -0500, Joel Fernandes wrote:
> I think we can incrementally build on this series to add support for the same,
> it is not something this series directly addresses since I have spend majority
> of my time last several months making translation *work* which is itself no east
> task. This series is just preliminary based on work from last several months and
> to make BAR1 work. For instance, I kept PRAMIN simple based on feedback that we
> don't want to over complicate without fully understanding all the requirements.
> There is also additional requirements for locking design that have implications
> with DMA fencing etc, for instance.
>
> Anyway thinking out loud, I am thinking for handling concurrency at the page
> table entry level (if we ever need it), we could use per-PT spinlocks similar to
> the Linux kernel. But lets plan on how to do this properly and based on actual
> requirements.

Thanks for the discussion on concurrency, Zhi.

My plan is to make TLB and PRAMIN use immutable references in their function
calls and then implement internal locking. I've already done this for the GPU
buddy functions, so it should be doable, and we'll keep it consistent. As a
result, we will have finer-grain locking on the memory management objects
instead of requiring to globally lock a common GpuMm object. I'll plan on
doing this for v7.

Also, the PTE allocation race you mentioned is already handled by PRAMIN
serialization. Since threads must hold the PRAMIN lock to write page table
entries, concurrent writers are not possible:

  Thread A: acquire PRAMIN lock
  Thread A: read PDE (via PRAMIN) -> NULL
  Thread A: alloc PT page, write PDE
  Thread A: release PRAMIN lock

  Thread B: acquire PRAMIN lock
  Thread B: read PDE (via PRAMIN) -> sees A's pointer
  Thread B: uses existing PT page, no allocation needed

No atomic compare-and-swap on VRAM is needed because the PRAMIN lock serializes
access. Please let me know if you had a different scenario in mind, but I think
this covers it.

Zhi, feel free to use v6 though for any testing you are doing while I
rework the locking.

-- 
Joel Fernandes
