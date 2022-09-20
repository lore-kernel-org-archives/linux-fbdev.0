Return-Path: <linux-fbdev-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 59062C6FA90
	for <linux-fbdev@archiver.kernel.org>; Tue, 20 Sep 2022 06:14:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229973AbiITGOM (ORCPT <rfc822;linux-fbdev@archiver.kernel.org>);
        Tue, 20 Sep 2022 02:14:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44532 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230209AbiITGOL (ORCPT
        <rfc822;linux-fbdev@vger.kernel.org>);
        Tue, 20 Sep 2022 02:14:11 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E74AD5C352
        for <linux-fbdev@vger.kernel.org>; Mon, 19 Sep 2022 23:14:08 -0700 (PDT)
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 28K1n9qS006028;
        Tue, 20 Sep 2022 06:14:03 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to :
 subject : message-id : references : content-type : in-reply-to :
 mime-version; s=corp-2022-7-12;
 bh=oJBTUR+AE3jlPjRkn4ICYL7K+tyqCYBgSnia6lW3cEo=;
 b=1FlOhfNrotk6WmTZabLfyp3z4ri6x2e3lp4FPzboXlwUGkPWSTF0lwzpScGTO9eBLPlR
 lpbe9FjCTt6Q/iYmVTH47wETflQYzYEPMeTVCnrShooKaS5jiRvu7UMslt4u/e+X6LDE
 pLhV3x60hDmDdcfhcyf1L5JzvrvCDeMlG5OKz18xtABCRg/HV0b735ca+BneIjtL/93i
 1AsuHYqcgRf488kgTu1ErjxX6xAC6smCPnsNW/G+ewI9N5OA9WbDnk6VpuL7V3QrQ/Bk
 0iG005P2i3qsxCnZB1sDdNBKyiO5ttwtDonOI11tey6hujWQ3zV/D6KzCRN95ok29xIx Lg== 
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3jn69knten-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 20 Sep 2022 06:14:02 +0000
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 28K41s1d036396;
        Tue, 20 Sep 2022 06:14:01 GMT
Received: from nam12-bn8-obe.outbound.protection.outlook.com (mail-bn8nam12lp2175.outbound.protection.outlook.com [104.47.55.175])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3jp39dc739-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 20 Sep 2022 06:14:01 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=M01++ZwZ4iMHoq83h9sVwMOA5/vBchAItGJ8yABxxwBdD8GbM3IukKAMe6ofL6xVrtMUFii8xGhw3HIDcJc4oeHvNeElFtB9aVes84q+xgvoZaTyU6yCsEE49Ac2eRuH+NpJCnsEfXgkv1jUOWCCVDwnx5OjNGem7dnyVuSKsr05173K5v7V9SqxLJU/DmKLk5KCw7KOrFqdmBh3cKXVviYAT+E29RdS1t6mw72EODuEZbpLX61NdfKgOQ7JAAZyOaQRI8QyDOVOIT/xljdZ3tMk9F829vkBisD8aFikxGl15rV4A5JMBKXiUnHIiU9cEzMip8eRtSfiydYjkncNhw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=oJBTUR+AE3jlPjRkn4ICYL7K+tyqCYBgSnia6lW3cEo=;
 b=UcOIuhm4y+F/d5gM3U81/45IcKaWvwuy0f+P+NJZ2ZFLxj74B42n/IgEo+gCYci2grvLer02y5/hsRAW3RvhwokbtHwzbgIPUP9wWhc9foLcl3T1trBa3VcmA7c/T5i4jiZxE6wJp1JyeatLwE+a4imezH6tIBq02VJqXpShTnPWAV83rV2drCDv88sJgfcJ2a0TE0hRJ7fGiQKwIvMVhbCXwOYQmdCnf/RHQTLf73PNBzOCVw4XgVc7O2z2U7CEAgmGUJLH4iN1YdxWFoodt3lH3qymdm4y4ijkDnHA1Q8ahETjhXxeQUqGzXNZcF4InpMAV6NbDptsIkH56y6Plg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oJBTUR+AE3jlPjRkn4ICYL7K+tyqCYBgSnia6lW3cEo=;
 b=zg6ElblxOj6S0/1wMKPXPDGvo6PY4G8mwRujtWL2adMK04SVFTioi437A9JTMghUrcI1gVj+QbrILHzgGDWCq5pkhSM4DRws6QkipDYVayem6wk9aYRMw/Jl8o8J1VjQ8dX3HOc29e4h8Pzzg9eBtAq+qRglntBvAEAtGSPnIMA=
Received: from MWHPR1001MB2365.namprd10.prod.outlook.com
 (2603:10b6:301:2d::28) by SN4PR10MB5800.namprd10.prod.outlook.com
 (2603:10b6:806:20f::19) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5654.14; Tue, 20 Sep
 2022 06:13:59 +0000
Received: from MWHPR1001MB2365.namprd10.prod.outlook.com
 ([fe80::a493:38d9:86ee:73d6]) by MWHPR1001MB2365.namprd10.prod.outlook.com
 ([fe80::a493:38d9:86ee:73d6%6]) with mapi id 15.20.5632.016; Tue, 20 Sep 2022
 06:13:59 +0000
Date:   Tue, 20 Sep 2022 09:13:31 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     Hyunwoo Kim <imv4bel@gmail.com>, deller@gmx.de,
        linux-fbdev@vger.kernel.org,
        Masami Ichikawa <masami.ichikawa@miraclelinux.com>,
        cip-dev <cip-dev@lists.cip-project.org>,
        Harshit Mogalapalli <harshit.m.mogalapalli@oracle.com>
Subject: Re: [PATCH] pxa3xx-gcu: Fix integer overflow in pxa3xx_gcu_write
Message-ID: <YylaC1wHHyLw22D3@kadam>
References: <YylXes0RnFv97uKU@kili>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YylXes0RnFv97uKU@kili>
X-ClientProxiedBy: JNAP275CA0062.ZAFP275.PROD.OUTLOOK.COM (2603:1086:0:4f::17)
 To MWHPR1001MB2365.namprd10.prod.outlook.com (2603:10b6:301:2d::28)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MWHPR1001MB2365:EE_|SN4PR10MB5800:EE_
X-MS-Office365-Filtering-Correlation-Id: fe36367e-f439-4c68-411b-08da9acf4e94
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: J0piJpvWYyQZdLFMo63WyWY7Lams4Qjb+4DrgSmkwD1G8BpGL/38g0ij99LERkPC2z+UlDuwYCcHI+3G8BUdT9cx4mZWXHNWjfKF11siC4+7PfJSifTNF5HQYcqIeJKFpNCg+C4u5qwyMAy+JsNA2NrVp/wv3dwbL8VxTmfYeG+CwutEN3wq4g0uPJt+1lkqVm4m2KPBCZ485vwe6M9QLPyBh4nSx+XDaXaoIhxvzKiDh15mcPTsq7oWYODsfBuVDvwm3v8PEY65b6TAIONfdniJer7Ehalw6k9GGWggO8EK1YenfxMWq80e9PWhPpRhSC2po8HALbiUpyL43ngRtj18hrQJacyWWRL2K9zGvx/IjOSiyKrxfYOnzBUYWMeppAKQivxuWuXu23iTidPQrQKeU3lV51uGaxfaE3/KxsXN9qeMF/HB9gAGLHHcj6n/3nvFERc9ezERQpoDpwge06ioS1g+JOKIxm5Z025A3l6jC91/LGMWW+THnLzKr7wge7L8CFsSZZlVmvGwQKWZi9X5meFeLj0Ctlxy6f12OM0/eO7ysXtpSf7ZJYP4EkPQpkh+Ynimhn6ODYNe7PccAdnbOO612Ds+XBPmXXDZV+hcSyhY8oaNZtd3Vi8vfKGO/G7jJnaEHzBfl74ZWM7+W95FKQ5L0p+czgqVQ2cbSyUdPiLQV3AzbppZPDyZg9WdV6Y5KF6/l7viHhUMAc15mq+apeucajoc/ZoSiEgBRiN8Yf7jGjs4O8F1meurFD2h1Kkw24TfQ7tMe10vKwPu/A==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR1001MB2365.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(7916004)(136003)(376002)(39860400002)(396003)(366004)(346002)(451199015)(316002)(83380400001)(8676002)(44832011)(66946007)(66476007)(66556008)(86362001)(2906002)(38100700002)(478600001)(6486002)(9686003)(6512007)(26005)(6636002)(8936002)(186003)(5660300002)(110136005)(33716001)(41300700001)(6666004)(6506007)(32563001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?Tnkaw6OTXcLmlADZQXP9pOkQGCnFmBCffrSDl6/mYQ42GdhMCEYXg1ALvE3N?=
 =?us-ascii?Q?56MSwGiIn1RG3Qt7mgg312kY6uoRy0U3J1twFtfZJ4F8TIyEL1ScuGHAWqVT?=
 =?us-ascii?Q?FBefkSXwrJK2P98NPZv6suUgXORDUFqIPswRY/Hy+awh2v+tyWKqTBmHR+qR?=
 =?us-ascii?Q?Ykp0mjBq4BZce+8uMwRZCcp9x4ZcfAp/tJd6KGVbLjnjgysfgOdjpnIVuizN?=
 =?us-ascii?Q?2udzGZVS585kpIz6kTmzAalNKLMPeQbS8t6seLS2V9ArGzNv1m9pf6+1+qtf?=
 =?us-ascii?Q?F3mZL2+BUfIyF6ucVRZsxuYL/e2FrxYDz1PWO88AlcGgUfSn+8/rL7IdOBr8?=
 =?us-ascii?Q?V8GXZ/yxNpr0xx4TUnCJ+XLO0SlNfe119nUAujj1UewX5aRdJ/2NYOzO2TbX?=
 =?us-ascii?Q?li60PwIAUT9Xh4Y3YCIe9oWRibGTxTYO543AFeX0x9xGIqmVsb/+1tOCXXh3?=
 =?us-ascii?Q?Fk1mEGN1lZGarqeLI66BKMTF3EJcjFiWfe6suMdX62MTZW+QqZz6glUMnedZ?=
 =?us-ascii?Q?DcDhBv2DlQpKUloET05J8jap+iA7VfqoUDvt9GuIUZWGOpY8WaxgTuQC7kqp?=
 =?us-ascii?Q?UrDfJVm1W/QtH2eyJGDC0MEOFEzkOon1Os9USc1VoVoxox5HWOjIkY5uym9t?=
 =?us-ascii?Q?qrGz9giDOSHuVEJvaSkyzfeYo8Iyz6aMHAGMlCNI9tslPhb4OnHH8RaD9JfO?=
 =?us-ascii?Q?X4Q7EgzzAAIVq29nXFQXIehM7o4LLOK2LOfe1AHxwvADqbzwFawy609BD2xT?=
 =?us-ascii?Q?+eDIJXYKSFKQ/4jR/dpx3SDROLwCd8f2KRCVcsSgRjkD7/Db0fDk4mbzRO9E?=
 =?us-ascii?Q?jeH0B+4OVWIGq/95OR0Snvc4P4sQYnmKPIxj0BLsnva1MdVJV+gGhP5kmGjk?=
 =?us-ascii?Q?TCIKgaEt8wdhAkY2S6HSQJXY0FHB69/ssgLCJrrjSyVs9nz1w7c+Lhb842wi?=
 =?us-ascii?Q?KFK353NjzQXWg6BAIeKqVkNKHMpdNsYdH6zro8D9Xdruk4zyXhJv/NuL+unW?=
 =?us-ascii?Q?OjezVfdHH9/k+hWZAGCEJSWBv5RICBbuZkQx1pYmi7TE0XblU0Jfde8Fimwq?=
 =?us-ascii?Q?1KdwRgOZUSicrwrB8qy3liZgc0kBQ26/C9A3cLgubBU2iszKOgesUEhMs04l?=
 =?us-ascii?Q?aXByOM64BnxtxEECAAFfJBnMWjsfGezU0q2uCDCVHrCIHYvlysBYibSzpBPD?=
 =?us-ascii?Q?lsB20+GG/pgEcThr1ELYxSZjg7JDLSSvIk/n4O0u6DbSXSXFwBw00GgZbWu7?=
 =?us-ascii?Q?jzikdfYxsq+BMx/RLtCGsiGKyYtVfii5OLlaGgZh9wVoR5eGl7LVXC4ehOU8?=
 =?us-ascii?Q?6VXSIr1vALL4KbDSw9gyI0UdrtGjmziJRvvcQjShxJaYLCd08Rx0vGwY5u3k?=
 =?us-ascii?Q?LuIVnUTeKSuOVscIpQ2TcaqLE4FcZaJ52c6g2z2qzES5HI9xbfkka8JBGbRi?=
 =?us-ascii?Q?WuxQNDzD6PMWl24tY1RaLEyps2EdYJlDWFfFlAkt0I8/UacL4qbgbzglbTR8?=
 =?us-ascii?Q?ByjYTkL0WW5AygtP3//eCtyPk35/p3TJLzb7GL6NqcoCRWglQb2jyKWqcWI5?=
 =?us-ascii?Q?RxBJcCDMjm0/YP1gN28FSvIS9Hxzq19MGtklnE2DmsBjR7P2AR8DceJoYXy3?=
 =?us-ascii?Q?bw=3D=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fe36367e-f439-4c68-411b-08da9acf4e94
X-MS-Exchange-CrossTenant-AuthSource: MWHPR1001MB2365.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Sep 2022 06:13:59.5155
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Dd/vt7K5OTvhl1tQcJ9vW5jcUTMmqw4ZWO7eW7esbV0E2OLrxrQJ9uQycJ3yJlUsOYpAhlX81EGOXqsi38b5BV6aYh8/fe4fEy1ahZBcnRQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN4PR10MB5800
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.528,FMLib:17.11.122.1
 definitions=2022-09-20_02,2022-09-16_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 phishscore=0 spamscore=0
 bulkscore=0 mlxscore=0 malwarescore=0 suspectscore=0 mlxlogscore=999
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2209130000
 definitions=main-2209200038
X-Proofpoint-ORIG-GUID: 6773-2DBLcIyxG7VVAK06yrimHypHl7g
X-Proofpoint-GUID: 6773-2DBLcIyxG7VVAK06yrimHypHl7g
Precedence: bulk
List-ID: <linux-fbdev.vger.kernel.org>
X-Mailing-List: linux-fbdev@vger.kernel.org

On Tue, Sep 20, 2022 at 09:02:34AM +0300, Dan Carpenter wrote:
> On Mon, Jun 20, 2022 at 07:00:10AM -0700, Hyunwoo Kim wrote:
> > In pxa3xx_gcu_write, a count parameter of
> > type size_t is passed to words of type int.
> > Then, copy_from_user may cause a heap overflow because
> > it is used as the third argument of copy_from_user.
> > 
> > Signed-off-by: Hyunwoo Kim <imv4bel@gmail.com>
> > ---
> >  drivers/video/fbdev/pxa3xx-gcu.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> > 
> > diff --git a/drivers/video/fbdev/pxa3xx-gcu.c b/drivers/video/fbdev/pxa3xx-gcu.c
> > index 043cc8f9ef1c..c3cd1e1cc01b 100644
> > --- a/drivers/video/fbdev/pxa3xx-gcu.c
> > +++ b/drivers/video/fbdev/pxa3xx-gcu.c
> > @@ -381,7 +381,7 @@ pxa3xx_gcu_write(struct file *file, const char *buff,
> >  	struct pxa3xx_gcu_batch	*buffer;
> >  	struct pxa3xx_gcu_priv *priv = to_pxa3xx_gcu_priv(file);
> > 
> > -	int words = count / 4;
> > +	size_t words = count / 4;
> 
> The count variable is actually capped at MAX_RW_COUNT in vfs_write()
> so "words" cannot be negative.  This patch helps clean up the code but
> it does not affect run time.

Btw, the other thing which prevents this from being expliotable is that
if you pass a negative value to copy_from_user() it will not copy
anything because of the check in check_copy_size().  See commit
6d13de1489b6 ("uaccess: disallow > INT_MAX copy sizes").

Linus has sort of gotten annoyed with me before for pointing this stuff
out because it seemed like maybe I wasn't properly grateful to people
auditing the code and fixing bugs.  I am grateful.  This patch is
totally the correct thing to do.  It's just that it's not really
exploitable as described in the commit message.

regards,
dan carpenter
