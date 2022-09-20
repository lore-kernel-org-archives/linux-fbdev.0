Return-Path: <linux-fbdev-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 36B08C54EE9
	for <linux-fbdev@archiver.kernel.org>; Tue, 20 Sep 2022 06:03:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230339AbiITGDE (ORCPT <rfc822;linux-fbdev@archiver.kernel.org>);
        Tue, 20 Sep 2022 02:03:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33350 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230218AbiITGCx (ORCPT
        <rfc822;linux-fbdev@vger.kernel.org>);
        Tue, 20 Sep 2022 02:02:53 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 860C524BC0
        for <linux-fbdev@vger.kernel.org>; Mon, 19 Sep 2022 23:02:52 -0700 (PDT)
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 28K1nT2x024499;
        Tue, 20 Sep 2022 06:02:45 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to :
 subject : message-id : content-type : mime-version; s=corp-2022-7-12;
 bh=NbbBIPFelnQSLYKh9uhHdHkwArlhGn8XNVn8bznnBLU=;
 b=sQ9gtIps2WjC/aO920Xu3wgzcrN1wNrAreKKh1PtiK3lZRx+NKJYXvau276qupvjtAt7
 oEKLsXfus4qDihzrOoSmKI8shCquo6glLs72OuV8KJIydea7RnXavnDp/gTvvInlUiit
 jYBfGUFoFUvTnwtZ7dekurwmdLBCQhpTsL0y8CSgZEl23M34mDOFDxfMHjyOhtdeTGe/
 o9nO7oHqc1LPoYqZmvWkFxzr6EK4rLEfsjVHgIvhmBdYOSIayd+d+OTIzce/Gc+hAYTW
 FSmUHBdWVMlR+MV6udeHEgQxL1BDA6LQT8nAHuWW2jnD1KTIAQjaN41ZJLy0xYYusWAW 8w== 
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3jn6stdw9p-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 20 Sep 2022 06:02:45 +0000
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 28K54wXs035885;
        Tue, 20 Sep 2022 06:02:44 GMT
Received: from nam10-mw2-obe.outbound.protection.outlook.com (mail-mw2nam10lp2105.outbound.protection.outlook.com [104.47.55.105])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3jp39jvw5n-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 20 Sep 2022 06:02:44 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KvdDTJWBAoruroNe377xAO15Oi5JqPTLYF9FnNDkPzk8fRgbt10550IzTLGUvrgCtIUVUoa2xV74fpAZfL5VPXmC0OojVLmoyROiohkumvcO8XalB2/kzkA7xRPxp7BpXBCt+4ReOyQ74umqHryRh4P2dFP/bQi9YvfGAGBQUgnHMzV1OO/XRcphNvUfYVEUCFTBny2GGSFYM+oPFyzpeCyWzQRJow9kBnPTQRayLxOFKXIZwrooqiQXmokfQ2OTX7hOePXxiQWw8U1uSa3XKZ+UDkc3aatDrwNg6eDwDUS5FEtcw4XnFyiKZ4QclHqMQDIJ7aMCLvoEXuLUxOFmmA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NbbBIPFelnQSLYKh9uhHdHkwArlhGn8XNVn8bznnBLU=;
 b=XBelCNrdAWCZgloa67oIuifLMOZARt6ZEanUefK3T2qJpFzosENSo2BOi73yIjgblEKHK40MJayCLMXfeQ2CHkRURS1NPMgPUhX6U11cM905J/zq+effEpLRW9cH6gb2fT2kVY3CzCYjKvj8uiDTxr0pjfMeT7CkbymiigejPGZMsIe4svTDZkiEnDgdQ+O8MpDy7abzVdzPCJoH6kHo5+znzzcBwLyt2OLkARRoSPE/LAgnRPsAM3sPXx5EEA7pkmd2DcOibyszY0uwHldvK+NUp8bIvk1qEuVgUjIgEW/YUuVeJnzrfmQkpEC7eFrUtr9g+f1vjDktO74yznQhvw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NbbBIPFelnQSLYKh9uhHdHkwArlhGn8XNVn8bznnBLU=;
 b=hwiZn3x+hg79q0S4v2zj+LyO1kDLe07BCqsuOEeRCL4FjicLww+p8qcvaBcKuD9qWWNwSICiJYvEo6KN+DDxdqxEU6+zRUVEPuO+ecICZu0aixTXuqj21PR7W4uU3A+ZTMrLB72JNIeb7u0sj0Nx47/7VHQpq5ZWch/ertVD7IE=
Received: from MWHPR1001MB2365.namprd10.prod.outlook.com
 (2603:10b6:301:2d::28) by BN0PR10MB5192.namprd10.prod.outlook.com
 (2603:10b6:408:115::8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5632.21; Tue, 20 Sep
 2022 06:02:41 +0000
Received: from MWHPR1001MB2365.namprd10.prod.outlook.com
 ([fe80::a493:38d9:86ee:73d6]) by MWHPR1001MB2365.namprd10.prod.outlook.com
 ([fe80::a493:38d9:86ee:73d6%6]) with mapi id 15.20.5632.016; Tue, 20 Sep 2022
 06:02:41 +0000
Date:   Tue, 20 Sep 2022 09:02:34 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     Hyunwoo Kim <imv4bel@gmail.com>, deller@gmx.de,
        linux-fbdev@vger.kernel.org,
        Masami Ichikawa <masami.ichikawa@miraclelinux.com>,
        cip-dev <cip-dev@lists.cip-project.org>,
        Harshit Mogalapalli <harshit.m.mogalapalli@oracle.com>
Subject: Re: [PATCH] pxa3xx-gcu: Fix integer overflow in pxa3xx_gcu_write
Message-ID: <YylXes0RnFv97uKU@kili>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-ClientProxiedBy: ZR2P278CA0014.CHEP278.PROD.OUTLOOK.COM
 (2603:10a6:910:50::20) To MWHPR1001MB2365.namprd10.prod.outlook.com
 (2603:10b6:301:2d::28)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MWHPR1001MB2365:EE_|BN0PR10MB5192:EE_
X-MS-Office365-Filtering-Correlation-Id: 0d461be3-9509-4c17-9c5e-08da9acdba57
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: d0RvJpMkUF8//wUnYC0BA1jki4OMyQq6w3npPVz7yvRMc+orFSa7I1hW/ilTvYh7xBCwm26DO5ED07jCmg/ouvRl85oCi7VYYc4YLC5jFQL5X2NJvHcbeGtw36Io//vce691SNG8XGqiIAatTn1cC1QmbqUfezwHayKCBslPHLyILkuENaPtg2k7zhhWerydMXwhKl5LRoTiMtYmVSIRw4F9Qac99Eo9NG3fFBjOA173Lasf06F+INfncaJK4MEg7Wc/PZ/e9NkBlY0JPD3xCT/vZNh3dlX9eB9d9Ire8byKTvCTAHQOSD47E7j1tSMBhs0uR9KAXwdaiaOj0i3jK0XIL9voANjID066VrP40me58vRAOvKmAv7krgFiJ+UgmgKe0xenTj/HGRjRPF/B+VvACv1xK83o5xyu54HjR0wQaHUvQ87J2nrR2DTDTgPPIZcv0kIqGCeiREKeg6Mw/VfZKZVkOl/+lgurAsJSZF6XPNRqcU0zojMKa0NkR3exzzDbBBDXDoPFkw9WYEU+Tj91fwyn+9nf3gn84wMA3kQoIzN278BsgMGJlTpgjyuFrt/mrnJXoWHL4zcEixkHjWawAh32Yz8qaXNFjXeMdQh/1p2bQ4xvH1FD9ewOFcdN3LYPxbrjyiq5X/1bF6ePVT0Li/NZYLq186eXbH6Dbhf218ZvlNPnCFZRsyDa6V+ihotWC6eza0TrLGOhBKoQvPD4OXlWACtJReEIAPBY/1/L03MkwAzbGt2syw7BHVY9hBo5Qcn4qyPPrknYJ6h8uQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR1001MB2365.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(7916004)(366004)(39860400002)(396003)(346002)(376002)(136003)(451199015)(2906002)(44832011)(41300700001)(6506007)(33716001)(6666004)(8676002)(83380400001)(66476007)(316002)(110136005)(6486002)(6636002)(5660300002)(186003)(8936002)(66556008)(478600001)(66946007)(38100700002)(6512007)(26005)(9686003)(86362001)(32563001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?wQLGkujmgRmQTBocodn1vOiXiXeBBa65GjneNDe7+VfwHtT4tIlI0G4AjT59?=
 =?us-ascii?Q?oeKPGcU2kOvmG1+SWxzzQ1Q1zpyyQyXspseRQZQ6dQ7p3myGeEsiKBlwgCQR?=
 =?us-ascii?Q?jH1h0qkPu5N4qfUCcN/6FSL1fwXRxtvmTjYXkMZEL3HjZPDuiJmp0/AQS6Yt?=
 =?us-ascii?Q?V4+5+Dc6W1jpgj/QlKEPB63IViLFh6px2hSbQd7Yz5omt3uI81ojcJgMSuMz?=
 =?us-ascii?Q?2PHW5D4ttBpq+mSZ4UjW6mR04JGGM/BoMrhtJXTL4R+UMzBfMf2BMhAOkZaW?=
 =?us-ascii?Q?Lc1UQXGbNPoih1WSckyxzQDbnqwB1G/Rin0SFD7PJvIrqSoQxPQ0DHZNlrCL?=
 =?us-ascii?Q?ype9oQrdd9T9Sy6plOZ27hEoltVf1aYRMxsyImzJcWagYqx4CwwlJu7VmF71?=
 =?us-ascii?Q?XVjeQQ4DWIByj+fYUdKyIRmJJTYqkLlkuqOv+r3ZsT2rXYuNUiVBS5F18cNc?=
 =?us-ascii?Q?dZcdwTO05uZ9Ql0GF9kbg6GVSk8zoPkm6Kmn9mIYS9zT3mQToqsn2cAr4X6M?=
 =?us-ascii?Q?KcdL7p5u35Q4D4pbp/23vasNeNJfbdZd3b6u+VjEn6EiP6SD0GO0ejWL2tZd?=
 =?us-ascii?Q?4rnwxQhTRHQlY5OKUMsQtbqaHpX6Jjzg1zkXgllx+okmZfu0/2Y45AxAEZ6T?=
 =?us-ascii?Q?4vR9L7MSrjb4UsqRkZvcmFAUD5nkJ2aKcM2yjo2z8DHbjjuPlQUTEtQhsjYI?=
 =?us-ascii?Q?2p6IUV6UHD03WMYqZ549Dhk8LQsZuaQod547O3ecwkexJAEsMQZCUgVU2I1d?=
 =?us-ascii?Q?KNnKrQNgvp7UpLPOgi2keBPhJ9o9pBP8QrQxvlqxPeDHlfSUumNeTr8/pYvK?=
 =?us-ascii?Q?j/P5Ttpftr59xDFqqTRrvi3kIRw+qdfTLOuEV8X1XcAB5e3iGrEcGrKDXQGt?=
 =?us-ascii?Q?K34LiAgD4KP3dXBVA6ra0J6N82tj9D3aY8VQpXIEkKeQqKaKC+F3l00Fd3/y?=
 =?us-ascii?Q?HJ7IM9SoZ1MZE/PVBG6GPM7je9LNdPE9bnMkqVTyw94jpy14Kdh6RclH8mwe?=
 =?us-ascii?Q?BRgEkoR8uX5ICN7WKWJcCgVgvUE0VWa/Wlgu9yb0QazyRVQg2KQHlqdeyGSI?=
 =?us-ascii?Q?XLcffGG2aMe/NAr/UYO4xOyw5nu/QGuZ1wqQSWC8FGJiSNUieh7DQaYvK2hU?=
 =?us-ascii?Q?KuzVcVLis42uCEaQSr9FuIx+iw/4V8qoOSy847v3PHLCrZy6seEb2LltSAYe?=
 =?us-ascii?Q?hHJo+t4hCzgPft80PiTx2TiBV3CZYc0i7FsmYXQRd2vx6S6dRUSzmWj893bn?=
 =?us-ascii?Q?rou7N5NtyoQ0QU+FVqC7JXCDIQCZbe8WhurQULWUQHohNVVXnTD8xBsUgXO9?=
 =?us-ascii?Q?mhTCmLqEzJuygkQAqE2xgBw+wmmSN/81X9NuRKfT6g47sEkxKgcYCGisE44X?=
 =?us-ascii?Q?OvDNQ18OiRry3rfUGLnFr4m3NYrMssAJLU93p7Km7DdPIiJrUVSY8TgSvxGV?=
 =?us-ascii?Q?8ZA6B+/zW7FXFNlSwefXDkivcRixpoQjL/4AwErZEVpzuywOj96ZNBvzjmAr?=
 =?us-ascii?Q?E1VRMJDRwHEWZKGTRiXTwEyodK4RTCu7N6l+qWSvLP7xMa9cTquRfThzDmPG?=
 =?us-ascii?Q?mCYm2wmoefglViC/0zxTQyLo7r1bGdms5PKpd5Z/BAwSdb2bwEuUOmPWd9YT?=
 =?us-ascii?Q?NA=3D=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0d461be3-9509-4c17-9c5e-08da9acdba57
X-MS-Exchange-CrossTenant-AuthSource: MWHPR1001MB2365.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Sep 2022 06:02:41.5841
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: WkqGXgHeTWly0dC74GqzlTkyGmXSFPSYVxb8/8dEqx2TCJ5Kyf/zTuqICqCs+jifX8ZCDOjpJiKeYZ5PavUuE4Uj8+L9HP4HXmB5W3I7C40=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN0PR10MB5192
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.528,FMLib:17.11.122.1
 definitions=2022-09-20_02,2022-09-16_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 bulkscore=0 malwarescore=0
 spamscore=0 mlxscore=0 adultscore=0 mlxlogscore=999 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2209130000
 definitions=main-2209200036
X-Proofpoint-GUID: qheyc8UZaKHMwzvFuQz3KKd4SJ7biiee
X-Proofpoint-ORIG-GUID: qheyc8UZaKHMwzvFuQz3KKd4SJ7biiee
Precedence: bulk
List-ID: <linux-fbdev.vger.kernel.org>
X-Mailing-List: linux-fbdev@vger.kernel.org

On Mon, Jun 20, 2022 at 07:00:10AM -0700, Hyunwoo Kim wrote:
> In pxa3xx_gcu_write, a count parameter of
> type size_t is passed to words of type int.
> Then, copy_from_user may cause a heap overflow because
> it is used as the third argument of copy_from_user.
> 
> Signed-off-by: Hyunwoo Kim <imv4bel@gmail.com>
> ---
>  drivers/video/fbdev/pxa3xx-gcu.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/video/fbdev/pxa3xx-gcu.c b/drivers/video/fbdev/pxa3xx-gcu.c
> index 043cc8f9ef1c..c3cd1e1cc01b 100644
> --- a/drivers/video/fbdev/pxa3xx-gcu.c
> +++ b/drivers/video/fbdev/pxa3xx-gcu.c
> @@ -381,7 +381,7 @@ pxa3xx_gcu_write(struct file *file, const char *buff,
>  	struct pxa3xx_gcu_batch	*buffer;
>  	struct pxa3xx_gcu_priv *priv = to_pxa3xx_gcu_priv(file);
> 
> -	int words = count / 4;
> +	size_t words = count / 4;

The count variable is actually capped at MAX_RW_COUNT in vfs_write()
so "words" cannot be negative.  This patch helps clean up the code but
it does not affect run time.

This is CVE-2022-39842.

regards,
dan carpenter

PS:  The other relavant code for people looking for integer overflows in
read/write functions is in rw_verify_area().  That function prevents a
lot of suspicious looking driver code from being exploitable.


