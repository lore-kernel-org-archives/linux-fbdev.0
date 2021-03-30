Return-Path: <linux-fbdev-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 37FD0C433DB
	for <linux-fbdev@archiver.kernel.org>; Tue, 30 Mar 2021 08:16:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E74E96196C
	for <linux-fbdev@archiver.kernel.org>; Tue, 30 Mar 2021 08:16:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231220AbhC3IQM (ORCPT <rfc822;linux-fbdev@archiver.kernel.org>);
        Tue, 30 Mar 2021 04:16:12 -0400
Received: from mail-dm6nam11on2081.outbound.protection.outlook.com ([40.107.223.81]:8800
        "EHLO NAM11-DM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S231521AbhC3IP6 (ORCPT <rfc822;linux-fbdev@vger.kernel.org>);
        Tue, 30 Mar 2021 04:15:58 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=oe3RV/zN55OXr1ioAzL+Pi2nUSGUEzoSSVUSxXNoYhHg7wQP92LS1klFcOh2ibtnf4P8aREVtYJMj65hsQ1xH8OiMU1Mh89ERhqXpwIqSpklm7luhO8dkc3jw9w2xRWBD0a8UINUU2yYg5DKjA/qkB8f18c8Cf54qrdda99wOxRtIR/s83p9V5Ajb11BzUtF6TNpsCgYL+dIKJztIVHxOJNMFJvmGnKyO8QSZ8iIFCdn6/ZhUkqoJ4YskCsSq9ZRJ++s4ryiB6wp7dp/MU82NwfEyAyZKW6wsC1PjHoZJYy8uaLAitjyQFpLwvHyNqUA0ArJF/vMo8LrjlBAkaGH2Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=n6REwXR7I/E3FjlEyCUYu/mMqWFSXGp3qOnGJMFfeTI=;
 b=C1JRzr3QXRQ9gdcbfy+4ZXU7aYCyjjg1ZvCI5+tC6i7zrUz36SgunHOPJowuIrP5aXgKpbxSEvNIVv/AaGRRmFYTXIt4dB6Vv+qF7i2S3iR+X1dpaJ8Sz3e9yolxYCAE/zzLsKmreB9ys1iNUPIsoHyQaXv2HJvaOKFPcD4yFDsV+zCEBlBHu7vfco/zuXUwpPcC7ix4WhRBfQgBjehVnHPlEFXRlr2x/UCh9e6FPasC/qVoZ6jt8CqqYOHrkuzmq2a1KTUtBPQSNZGNLTOkxFc8uL+kKJCBy2RE48XE6LkWiObM5emxPYTa04fWAlShdhkJbv5IsF7oqhr5zr8HAg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=n6REwXR7I/E3FjlEyCUYu/mMqWFSXGp3qOnGJMFfeTI=;
 b=VoPS2qUTUreQEtrz8WcfJwK6lr8wP2gRbCVngLlgUkxXtQC61SpTRv4sHULybHbjqMvhUqru0mstvhDmO9eyadj+sqLqYbsPeAkQNKXsewMAZGoasvwWbYIJ40YLXch3pdrfH1QCP9xgisua4eakfR0mzTR8pzOdtbSyY6bFOHs=
Authentication-Results: kernel.crashing.org; dkim=none (message not signed)
 header.d=none;kernel.crashing.org; dmarc=none action=none
 header.from=amd.com;
Received: from MN2PR12MB3775.namprd12.prod.outlook.com (2603:10b6:208:159::19)
 by MN2PR12MB3792.namprd12.prod.outlook.com (2603:10b6:208:16e::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3977.29; Tue, 30 Mar
 2021 08:15:55 +0000
Received: from MN2PR12MB3775.namprd12.prod.outlook.com
 ([fe80::c1ff:dcf1:9536:a1f2]) by MN2PR12MB3775.namprd12.prod.outlook.com
 ([fe80::c1ff:dcf1:9536:a1f2%2]) with mapi id 15.20.3977.033; Tue, 30 Mar 2021
 08:15:55 +0000
Subject: Re: Interlaced resolutions hang the desktop
To:     Alberto Salvia Novella <es20490446e@gmail.com>,
        amd-gfx@lists.freedesktop.org, linux-fbdev@vger.kernel.org,
        alexander.deucher@amd.com, benh@kernel.crashing.org
References: <CAHJvkbsexf7kM-11ZdrM+pHUUyvttB8fyJMfcsQAC1233jp8LA@mail.gmail.com>
From:   =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>
Message-ID: <388b2a9d-0e63-b70f-28ed-6297a524fb76@amd.com>
Date:   Tue, 30 Mar 2021 10:15:51 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.1
In-Reply-To: <CAHJvkbsexf7kM-11ZdrM+pHUUyvttB8fyJMfcsQAC1233jp8LA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-Originating-IP: [2a02:908:1252:fb60:8ca4:a46e:6aa7:208c]
X-ClientProxiedBy: AM0PR01CA0078.eurprd01.prod.exchangelabs.com
 (2603:10a6:208:10e::19) To MN2PR12MB3775.namprd12.prod.outlook.com
 (2603:10b6:208:159::19)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [IPv6:2a02:908:1252:fb60:8ca4:a46e:6aa7:208c] (2a02:908:1252:fb60:8ca4:a46e:6aa7:208c) by AM0PR01CA0078.eurprd01.prod.exchangelabs.com (2603:10a6:208:10e::19) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3977.28 via Frontend Transport; Tue, 30 Mar 2021 08:15:54 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 90612414-22cb-464f-070b-08d8f3540a72
X-MS-TrafficTypeDiagnostic: MN2PR12MB3792:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <MN2PR12MB3792E4EEF1C553ABFA6F7DB8837D9@MN2PR12MB3792.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:7691;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 58Vc+Q1gr/y7kOdFdfLZm69PGUH4jDuFBe3S0FTKH7OcC8qKdF2jDW/1LCNbBZySTRcMwpoODOELkjCrE9Ks/sAYneQqUOTm4o5IoINSjqsO6JSyln4/lhDQuZm6M57FU8/tO/oHy1IwJDACle5CrHtSzBoMb78THQVNnn5Z/yK4iZHvNA0RtxXJXIX0JrsYEVWu4Gkzf2h/SGm688EGlgW8SER4W5Geseig9yArgszd74T7JNmmHROe97WbDbwY/Ubp3iAXKPrLMpijiA+HoN0DBzZIJXGAnScCXppDgSiy/Q+aCI3lY+JMaRAxbCvlSCP01f6GUp/oEtFRFCOnWHVBdY34BSXUSoHSdx0qiricVBdGrV0U/Wspj3msCOrdKKe2paEiQc9OmeDW3WsyS1aB6TZShr6fXDkfUGJmV4l/BYlIsMFgIfn25cIYWYA+guMuDuEQNhjmAcHZiKH2a8vqG0JTCq/96zFSDHkYkgV1A7KLcDd1ZzZL4lhdukRRl3jq59ROjH5o6CuJ8SnzZ8gyeUURDn4igVsg/aYRDT+gwupFgmJgoAITP+omz+l1w2sZAaonM7FvRYNZrj+V7soWKOtcZkSpE7uXOUFa6m2YXcC69gn7OA6uDWtMptX8ksq6DqWLr/1zNdcxuBmyBF1DtZEForkYhAQcT3xBhf6wjcWWxwm88UsXqFA7V7Fn
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR12MB3775.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(136003)(396003)(366004)(376002)(39860400002)(346002)(36756003)(8936002)(316002)(83380400001)(8676002)(4744005)(2906002)(5660300002)(52116002)(66946007)(2616005)(31686004)(66556008)(6666004)(66476007)(16526019)(6486002)(186003)(38100700001)(31696002)(86362001)(478600001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: =?utf-8?B?RURWN0traHl3U0NieGNxVFl1YmFjbEErblFvS3pwN3c3YWJiaFZUM2RhSnZN?=
 =?utf-8?B?UVhQaktLYXN4Y2d6blZsRXloaEd6VER2MWtFWXBOV2xiMVpKRjN2TVNtWmpw?=
 =?utf-8?B?ajBEdVN2bnBjK0V0WVhySEUrSkFEWG1TdkdVRDZETllLeU5CS3QzL0JoM3hX?=
 =?utf-8?B?dUZoR1RZWVlaOXNPOVJXRFEreUNwKy9HU0VyZjU5NXhLaTlxcVg5eUorNXZz?=
 =?utf-8?B?aXA3eERSNThiTjl6WmhVbkxwZXpGeXF4WXhZYUhaN1JDS3dHeEFFQ01YcW95?=
 =?utf-8?B?Q2FyVnR2dFhOZkVjN2V3K2JNREV1S0g3Z0pmclRxZ2ttbm84d3E1OGg1VzZL?=
 =?utf-8?B?VUVVWnY2R0VQYXd3T3BPLzEzdGhsUjlQcm9lNkMrVG03VVAxS0taL0JtQ014?=
 =?utf-8?B?ZXRicmR1TkFSTmdwbUxacDYxS3dicHFSUFB3Qzh1UW1PMnhGSk5QRW9sYzYr?=
 =?utf-8?B?R0daM3lHVVVoWTdyNWZPMno0RzJpa2lORVZoQ1l4QW92Y2tmbE9iSkVpTHNG?=
 =?utf-8?B?YVdIRW5JWTVyRWVieUVvaURhNFpDa1ZGOW44cXFVdXlWRDRRNGFTUWZwa1NX?=
 =?utf-8?B?TkVvOGJWZkRvcUpxV3Z4UUliNklVaU1od0gxbk4wNXZKUzg2cE1PWm5pM3ZG?=
 =?utf-8?B?ZDFZc2RRZTJ6TDZUMzhzRHQxNm5MQUt2KzRBMDl1OTRvenk0VEFPTXVaeWxF?=
 =?utf-8?B?b0dsOVA1MzhFakppYXlFS2gzZ0ZVKzdqS0FpK2tyYXprUEVOTWZuUkZTQkJ5?=
 =?utf-8?B?L3ZibjFRYUV4L0tWcm9uZDZ5WCtJcmUvZ0dNMjVLRFJsREt3Y0Q2K1Q1VHJ4?=
 =?utf-8?B?MXQzbXl1UVZEczJDY1AwKzVFb1dRT093Znd3RU9DUGkxd1E3WkZaN1Njc3dV?=
 =?utf-8?B?QTQvdlNBR254b3JGckYyNWViOE9WbVFZT3dyd09SdHBKdTBxU3hnckJFUTBQ?=
 =?utf-8?B?cnJpS3Q4SnVMR1BGdERkbGxlSjNZZ0RPVjhCTGwyUGlqMGlZUkVMeDlOMGRV?=
 =?utf-8?B?d3c0b1F4Q1B1eGI1b093MGx0WXZ4MDl1djRlVm5XUU8zUkpOTnhPVUJEcjl5?=
 =?utf-8?B?YTNldTVkSEJNSUc1RDNTN3hZMVJNelhTZHFHT2UxYjVvODY2eU5ad29OejJ6?=
 =?utf-8?B?M25peEJrb2hkVkRyS2NRV1Y1eGNjRVlIUnFiaEphblg1RGpOcEtUUWhxYmh6?=
 =?utf-8?B?eVh1RHl0VUNnVlk4TGQwOVJnRk1TUzlCU0FRTG1WU1hDQU1yVXh3c2xtMzFW?=
 =?utf-8?B?c2Y4RTJjcVcxb25HbXFpRWtxTWVySjF3NEVaT3E1aURCQit3UVNScmhqOWxk?=
 =?utf-8?B?TXdQVkRjU3MvRGk2NURPdlBFVkNudEdtYk1KcmtncWVJQzFySkt4VDdxVHZB?=
 =?utf-8?B?ZXhNM3EvdnBNMU15MjJYY3lnZXBNWTNHbkVISW9SVXZqVGNlckJFbm5Bbml0?=
 =?utf-8?B?L0ZLN2QyaGwva2JXVENoSjBXc21meHlNQWl5VzZEY0FUYy80WUQ4OEtWcFlr?=
 =?utf-8?B?K1c4cGlKMWFGTXRNTnVpOENLREhJZWlRWDEvc1YzSW0wUmVrZkVhRUdONlBI?=
 =?utf-8?B?ZjFxU3FjMitoZSsvWmR3M0VTOHV4cjJNQ0dzekZZb244S0Z5WHpEQkQvSW1B?=
 =?utf-8?B?bWQ1WkRSVnRpYnhzV2VqaUxicVpaN0pPNEgxL0xOcWU5ZlRPd3Zsa0NqQmpS?=
 =?utf-8?B?dUdreE11T2FLZDQzOGdVY1JoWUhaS2wrSVRSdjJSdXZPaVBOWk5saWV0Vjcw?=
 =?utf-8?B?aFFZa2VaRHRFV0M5TWQ2ODhZRnlNK2lWc2ZHL3gwMnMwMkt1LytFUWh1UTVQ?=
 =?utf-8?B?c244azFyek5WUUVtN2p1VXpqODZkNVptbWRObDkxR3AxRVUwcy9Vank2L0xO?=
 =?utf-8?Q?DXnrGYcZnFtY3?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 90612414-22cb-464f-070b-08d8f3540a72
X-MS-Exchange-CrossTenant-AuthSource: MN2PR12MB3775.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Mar 2021 08:15:55.5250
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: BiGi9K5joi7N90TZjuViwIKCEe6foW3TRRjFCd0e7fdBTS/I6VxrShJ6Q4p4lJOu
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB3792
Precedence: bulk
List-ID: <linux-fbdev.vger.kernel.org>
X-Mailing-List: linux-fbdev@vger.kernel.org

Hi Alberto,

well what hardware do you have?

Interlaced resolutions are not used any more on modern hardware, so they 
are not well tested.

Regards,
Christian.

Am 30.03.21 um 10:04 schrieb Alberto Salvia Novella:
> The entire desktop hangs after some minutes when using the module 
> "radeon" with an interlaced resolution.
>
> Easier to trigger by playing a video on Firefox, at least on kwin_x11. 
> Wayland didn't exhibit the problem.
>
> Other display drivers, from different computers I have tried, didn't 
> allow those interlaced resolutions all together. It seems they know 
> there will be problems.

