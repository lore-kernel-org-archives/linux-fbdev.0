Return-Path: <linux-fbdev-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 83398ECAAD8
	for <linux-fbdev@archiver.kernel.org>; Tue, 20 Sep 2022 07:13:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230195AbiITHNj (ORCPT <rfc822;linux-fbdev@archiver.kernel.org>);
        Tue, 20 Sep 2022 03:13:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39314 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229667AbiITHNd (ORCPT
        <rfc822;linux-fbdev@vger.kernel.org>);
        Tue, 20 Sep 2022 03:13:33 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3A6CE5C36C
        for <linux-fbdev@vger.kernel.org>; Tue, 20 Sep 2022 00:13:30 -0700 (PDT)
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 28K1n992006028;
        Tue, 20 Sep 2022 07:13:24 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : content-type : in-reply-to :
 mime-version; s=corp-2022-7-12;
 bh=y+1m6xZ8XZ17K/AA8mfjAmXgUBF/nq23Ujge60StAf0=;
 b=o901vNctuCGqMubOAgGmHWYi8+lcq/iJ0PlOSrpG1FbHdF67ScNJTxaTFYHtdGZBTwC8
 tJZZlRnzLxHIhSESGBvYPWdo7yio5BOojyh0iOebSlsZbMw8NFX4tyFFbHizbfbuW7KW
 5k6DriUhHXlbcjRQ+SNZZ3H2f9maVndV90bRhXd1oSJvHoez5f7I3jEOnCz0vFZnHAYM
 iIjOd7hpYaIx3J5htf1JZrbUM9byTtglHxNlbqq/ypg1WXFakjcIrP8UWu4l23Ug8/sW
 C+QbEzJFh/xxEo4zkiazY4XKk10E+JCeE4gXyWnfaHQqw2v1CPTfllWwZoxKVb3/VpWS Ig== 
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3jn69knxnn-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 20 Sep 2022 07:13:24 +0000
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 28K5p223036303;
        Tue, 20 Sep 2022 07:13:23 GMT
Received: from nam12-mw2-obe.outbound.protection.outlook.com (mail-mw2nam12lp2040.outbound.protection.outlook.com [104.47.66.40])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3jp39dds9s-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 20 Sep 2022 07:13:23 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=PwZzlpYKNCmw1DySFZAiTez9qfz9O/NglYk8zD/5NQ+mom0AGGK4JnCwmFblf6VEBwIzez4/pWxYqangB5dNhULvY30EP24y/k2NMbC6Z1lOk4E/LfJZFntaLTw3HICuQkNLLlZhroQCXkwc1Ugbyho62ol31cWB6c308b8U4XnEgPrN4YXuAcvkq9r5cW9qDzb7BQrbxYejVU7lGyJ2+UeWpZlOPs+PzNMWCDvy3hQXYUtbJmnwu5OWYDqkDFpt/xirQ3VzUH4DGf8TJwrTg7lyqJH5+FGmJVzaBuqphe/L1m+v4clH+Q9ciHW4HAkdwPW02s5b2mM/U/BdxYYo7Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=y+1m6xZ8XZ17K/AA8mfjAmXgUBF/nq23Ujge60StAf0=;
 b=W4MRH4THF3xO6z8xKL9kp8mcK7p0LFi/1G+2kRMLpQ44DvwW5RhElRc8SHyq0GMuE2KIVyd2t4YFl8ogwoMROomAqH7lnQ4aVvNvPCGqlBwb5zVyo5dMtJjYfV1NvpTmv/rQQLuo33bpC6/vzK1DUzRqJxtd8qy1NN5S/gRP4S6CzZtUknC+YZeLS/GM4eLSg0Zq1nTSikCC9CCnP0GYc1Q1kCwLxDtLVU/7O+oX/zXzmaPpJqdCV3Jzevj9mV+8OlKLtJi/8xk36Obe9WFib526lWG++Apk/wClJBLIz9FsKFW8ludN+K8/qhd42piwKXkMKdGxhxQVGwaPY5Evqg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=y+1m6xZ8XZ17K/AA8mfjAmXgUBF/nq23Ujge60StAf0=;
 b=WJiPv4+kAR0ELjD02IMcgu4r0oYLcYxP0Dp2gCDgiJ9LMv3z0AdbzzrjsQeHlGIf8w6iQeJfU+0+aos6WkH4/droffJk/zBsO1rUepiHGjhCKfEBv9JdjUuWmha+AXCSIs4VY53oOuHafXgehUex/Kh5XPuZ65/y/yKQZxdYOsU=
Received: from MWHPR1001MB2365.namprd10.prod.outlook.com
 (2603:10b6:301:2d::28) by BLAPR10MB5380.namprd10.prod.outlook.com
 (2603:10b6:208:333::14) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5654.14; Tue, 20 Sep
 2022 07:13:21 +0000
Received: from MWHPR1001MB2365.namprd10.prod.outlook.com
 ([fe80::a493:38d9:86ee:73d6]) by MWHPR1001MB2365.namprd10.prod.outlook.com
 ([fe80::a493:38d9:86ee:73d6%6]) with mapi id 15.20.5632.016; Tue, 20 Sep 2022
 07:13:21 +0000
Date:   Tue, 20 Sep 2022 10:12:59 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     Hyunwoo Kim <imv4bel@gmail.com>
Cc:     deller@gmx.de, linux-fbdev@vger.kernel.org,
        Masami Ichikawa <masami.ichikawa@miraclelinux.com>,
        cip-dev <cip-dev@lists.cip-project.org>,
        Harshit Mogalapalli <harshit.m.mogalapalli@oracle.com>
Subject: Re: [PATCH] pxa3xx-gcu: Fix integer overflow in pxa3xx_gcu_write
Message-ID: <Yyln+y2qBST4IRIi@kadam>
References: <YylXes0RnFv97uKU@kili>
 <YylaC1wHHyLw22D3@kadam>
 <20220920062241.GA321122@ubuntu>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220920062241.GA321122@ubuntu>
X-ClientProxiedBy: MRXP264CA0007.FRAP264.PROD.OUTLOOK.COM
 (2603:10a6:500:15::19) To MWHPR1001MB2365.namprd10.prod.outlook.com
 (2603:10b6:301:2d::28)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MWHPR1001MB2365:EE_|BLAPR10MB5380:EE_
X-MS-Office365-Filtering-Correlation-Id: 7b08a306-2d03-4b66-0bcf-08da9ad79969
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: USZ/x/bO4vZs1sA/MQbE4oLgXxeXlTG60EiU+yD0RMI8IoCREU38GwgIpGc2kDknVIaMHtoeovsNIKGUmSKjhtE16lECapW7Dgb/WTFRRBeBGjjhttv0sfoyWa8nTq/eDFAKvahNMPIven0tZCUTKXHz/Pw77MbrC8BTLzXoX0OjvbrOtLrRAkF34xi831BdgwGbfBAS/r/NSWPoMLxRl+bKqzKAAV6DxDUgBmZwN02VUG2uu1BikeJ0VufUtnoTlugb9dQZA+VKudrmeWESSzyf6n6XHdykOBlSaSrfBDwg3G+X/DGQIxxEB2H9ULZyGPjyjpWCgWwzVKE+jmUcLr1fXPz0lJOmhtosLxvnc8RvI0+W3S35OmRPFJc1ywxJRiIuFpkk5GM/VG/J9U2/rQpOFYjYh0CsoqRlIEGnnJxy5E1nbsNxsGTviG1bLiL2eUhKEKR9sY1fGONoFV/CeHxnlAfNLQDwF67oh+wTM79I5/H5BPCXW0ag9+LWvj2CjZQwijikmjtnwlQZ7z3pQuOFPfA0jXmz7xF//8BNQTB5ljCMrSXipaie9zVW9sC4XL57FyqYPPaKP6bgKpWb4onRFM/a/BIBtnY0xyQ50eCrPQR8AOZNQMVyUoqL5lgpB98smpFwtPApjfW7tp2vLSbwkKYHydNTMETM6D+E3BFU/+0Q2GAJ/zTnEV/mZPOHV9LBRl5PuIauirSMxvNbl9kShy7ZKt2FYkoSDMDr8Adx+q3lchLrVAaTwFIbtno/uVsrSz+ac+ZeWewZzlIxeQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR1001MB2365.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(7916004)(366004)(396003)(346002)(376002)(136003)(39860400002)(451199015)(83380400001)(2906002)(8676002)(6916009)(54906003)(44832011)(5660300002)(316002)(4326008)(66476007)(66556008)(66946007)(33716001)(86362001)(478600001)(6486002)(6666004)(107886003)(41300700001)(8936002)(6506007)(186003)(9686003)(26005)(6512007)(38100700002)(32563001)(67856001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?F0OSg7gfI8BXgNM6ghqjaFGFxr3xUzJh5l76li+DsHb7OeNFpcGF9gQTkAQo?=
 =?us-ascii?Q?WOkmpoNBwT/rMC+OJX6auo6iR2I4HmdjdSNrdXf192it39xGf6N76Yh/6GC4?=
 =?us-ascii?Q?WOuVQi8sCSXoaK2G9UxKS5JXDRpocfV5PVLzm0HdcQALOJDWXrcKlRez/9Es?=
 =?us-ascii?Q?FKhgPxaoQb/yzO8aFYkmUyBnUEzZv06mCwT4ScYFIfScISjuTcMptNNycxLU?=
 =?us-ascii?Q?hN6CPcPpMQkvUX+tbmC1yhGZ9XY3d6kqtjEhYLOTSF0gEgbHwYTr1Bvga0Vy?=
 =?us-ascii?Q?GJzgLuIdPG88KHJN6eamTij8OVKQgSzx7K/UBSWyx1z0WGonxFWjZbfZa0Qh?=
 =?us-ascii?Q?V7+ukwksiFUi0MAp1tY6KkS7NzAhl+AMfCgaPAsc6IMj3oeQa0ZW+SwYSbcB?=
 =?us-ascii?Q?Bgy6xKgU7SBKOIBxVASlLVs1sauXeHI1ofUbmKODw5V3aoYcN2E/dLSX06Yz?=
 =?us-ascii?Q?Myubm/0jzpOnWKfNgegIheHOzLwSg3m+kUt+qio8xzpO3jEKbnmmjbmQuZu5?=
 =?us-ascii?Q?eyO+87mGP43gRVKdvgPLp2PN3+QEiFtMIDFLdAmyVnxFS1UREPyRiGBsDNFL?=
 =?us-ascii?Q?pi75jfNseityHQvZq5wx3xBYDGhRCEeWEwo/m8Qve81iEGjpasArIDbPckfK?=
 =?us-ascii?Q?7oZbYp+6/r0ZYnSd/Ept921LvqX81C8stD9WzO1oWN+S9pvDbdfKODwNiz5c?=
 =?us-ascii?Q?+3OG5WyT2EPQ5KyRAvdO0qMrC0geyzpW3Mkt11VAhVxWXYSMGtQZiVvJ/kVU?=
 =?us-ascii?Q?WB5AjANsMNWkvOkAsEc+C7TUF8pimGzAfo0VwMtWi9oR1m9gAKB+sZRRihBE?=
 =?us-ascii?Q?ypHneiYiAn4UF0l2LbDhkSUXsBFVyC7b7XB3BOgeFeHzuoqausjgJPqja3zK?=
 =?us-ascii?Q?df6LCeQmZgSn4K75ZNh3DGUI/zUAvXoqAyNZpwP7qibl3b23icXZGkpY/iyh?=
 =?us-ascii?Q?aLewanGg0N33YWDgZa/4p0qtNZHJafWPZdhoeeNAOx25x/ENNWjUsSt3r9VY?=
 =?us-ascii?Q?fO55ZJYFh7fyY+n2+e0E6BAfAv6DQFRsZzhAbDbDLvD7JKISmAPNBDC44U7S?=
 =?us-ascii?Q?nJqQL3xXMMmljvbYSZTzJwIbhZqrgV9ZMthrhj3cA6CZpRe0wikcr+v+YaGY?=
 =?us-ascii?Q?MWt0Lb+Xgo2lcKJUC22GKqlVHWAMg7iIL0v5/3opLv4sESbwEXSd3Epmum9n?=
 =?us-ascii?Q?t7dMDXxiQQVh7rq4+z3mQesUJIE9H4+FgBdGc1I5M9UQr35LOyf/qfd3H6fN?=
 =?us-ascii?Q?Trs/CrbLUY6MuLsgZDDiCG7ZIESbgULUblUEkHYszFzPOf0vtOoeDZmCvo2Z?=
 =?us-ascii?Q?SpoDxaKUvcp5+JfzxnLXrGrBWOhGnfcbucrBRCU+DHGaLSyKaSA2A9RwGp/S?=
 =?us-ascii?Q?l7pNHwXVoJI5b+QnAb6BkIHD7aywYhX1XFyGVAQMppwWKPD+KFJy9EZAS8h/?=
 =?us-ascii?Q?t3rCVfFQtlnaoMweLjMm7lxuiAd9cKKKNduFR40pMXx81M1EJDTm9rXUZatQ?=
 =?us-ascii?Q?C565BDfarmsTdq+xyBkwKyNcaWwhyMg5bL2OKeCtRVX8S+UQaJHdVKLwmXBe?=
 =?us-ascii?Q?q/F3WHXo8eRTZJr+AvtVlyRXxb9/u/rqyqC+NKCymazR/vH8XkL8J5sj/t+n?=
 =?us-ascii?Q?4A=3D=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7b08a306-2d03-4b66-0bcf-08da9ad79969
X-MS-Exchange-CrossTenant-AuthSource: MWHPR1001MB2365.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Sep 2022 07:13:21.2072
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: oNQoJpXLXp3fQKci0PVdje0U5V3A6VkVuJJ3QYgbCINHZMxMPMEUjEMSNNDh6Jv/Kee9mpoc7Gcsptp7r/rb4o0U8EYLskpnqj3pGpQUK88=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BLAPR10MB5380
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.528,FMLib:17.11.122.1
 definitions=2022-09-20_02,2022-09-16_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 phishscore=0 spamscore=0
 bulkscore=0 mlxscore=0 malwarescore=0 suspectscore=0 mlxlogscore=999
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2209130000
 definitions=main-2209200043
X-Proofpoint-ORIG-GUID: mQ_iekpvCRkNyXJcOn7k30PRZcieI4_z
X-Proofpoint-GUID: mQ_iekpvCRkNyXJcOn7k30PRZcieI4_z
Precedence: bulk
List-ID: <linux-fbdev.vger.kernel.org>
X-Mailing-List: linux-fbdev@vger.kernel.org

On Mon, Sep 19, 2022 at 11:22:41PM -0700, Hyunwoo Kim wrote:
> On Tue, Sep 20, 2022 at 09:13:31AM +0300, Dan Carpenter wrote:
> > On Tue, Sep 20, 2022 at 09:02:34AM +0300, Dan Carpenter wrote:
> > > On Mon, Jun 20, 2022 at 07:00:10AM -0700, Hyunwoo Kim wrote:
> > > > In pxa3xx_gcu_write, a count parameter of
> > > > type size_t is passed to words of type int.
> > > > Then, copy_from_user may cause a heap overflow because
> > > > it is used as the third argument of copy_from_user.
> > > > 
> > > > Signed-off-by: Hyunwoo Kim <imv4bel@gmail.com>
> > > > ---
> > > >  drivers/video/fbdev/pxa3xx-gcu.c | 2 +-
> > > >  1 file changed, 1 insertion(+), 1 deletion(-)
> > > > 
> > > > diff --git a/drivers/video/fbdev/pxa3xx-gcu.c b/drivers/video/fbdev/pxa3xx-gcu.c
> > > > index 043cc8f9ef1c..c3cd1e1cc01b 100644
> > > > --- a/drivers/video/fbdev/pxa3xx-gcu.c
> > > > +++ b/drivers/video/fbdev/pxa3xx-gcu.c
> > > > @@ -381,7 +381,7 @@ pxa3xx_gcu_write(struct file *file, const char *buff,
> > > >  	struct pxa3xx_gcu_batch	*buffer;
> > > >  	struct pxa3xx_gcu_priv *priv = to_pxa3xx_gcu_priv(file);
> > > > 
> > > > -	int words = count / 4;
> > > > +	size_t words = count / 4;
> > > 
> > > The count variable is actually capped at MAX_RW_COUNT in vfs_write()
> > > so "words" cannot be negative.  This patch helps clean up the code but
> > > it does not affect run time.
> > 
> > Btw, the other thing which prevents this from being expliotable is that
> > if you pass a negative value to copy_from_user() it will not copy
> > anything because of the check in check_copy_size().  See commit
> > 6d13de1489b6 ("uaccess: disallow > INT_MAX copy sizes").
> > 
> > Linus has sort of gotten annoyed with me before for pointing this stuff
> > out because it seemed like maybe I wasn't properly grateful to people
> > auditing the code and fixing bugs.  I am grateful.  This patch is
> > totally the correct thing to do.  It's just that it's not really
> > exploitable as described in the commit message.
> 
> I found the code that might have the vulnerability, and submitted a patch without actually debugging it.
> This is entirely my fault. sorry.
> 
> Should I submit a fix patch that fixes the commit message?
> 
> Sorry again.


No no.  No need to appologize or resend anything.  This is just
information to help in future research.

regards,
dan carpenter

