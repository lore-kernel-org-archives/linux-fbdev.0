Return-Path: <linux-fbdev-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.5 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D8C6DC433E0
	for <linux-fbdev@archiver.kernel.org>; Tue, 26 Jan 2021 17:23:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 945DE206D8
	for <linux-fbdev@archiver.kernel.org>; Tue, 26 Jan 2021 17:23:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729659AbhAZRXD (ORCPT <rfc822;linux-fbdev@archiver.kernel.org>);
        Tue, 26 Jan 2021 12:23:03 -0500
Received: from aserp2130.oracle.com ([141.146.126.79]:54554 "EHLO
        aserp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389757AbhAZISv (ORCPT
        <rfc822;linux-fbdev@vger.kernel.org>);
        Tue, 26 Jan 2021 03:18:51 -0500
Received: from pps.filterd (aserp2130.oracle.com [127.0.0.1])
        by aserp2130.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 10Q8F7t8039323;
        Tue, 26 Jan 2021 08:18:00 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=corp-2020-01-29;
 bh=lKVOl7uXOdllN9n85WrweQqwB29zeAj4HNPLJba3Rns=;
 b=wDAZMk6Yuy0ovRIUxF70h/49y8SDZDVxlm2lgK/VwRkVY301/GXJKzKkAR8MXRwnVIQL
 2922r+QsPuv3gNGliECBLcmulJqxPNCEOgSmMe4w5VPQM1bSvc+SwnGFdhHd1Nn/Rk0x
 eropp+KNcnkKAiBZgknRSlBuGz9SFRGd82tfn8OYvrpK9P2mLrdVrdvybt0xJSr9ased
 YJoRgO+aIh8teWAfa76K+cjVlALR+mxgiXrGEzB4QBRMQOucMcBuvCkeREEFqJuRG2hA
 tSKVCov90YGonOyKRJ+QqljFnhIy4fdUanYvZtJq2q8lhNGOMiG4MsZHSpq66r1aGPTN cw== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
        by aserp2130.oracle.com with ESMTP id 3689aah2u2-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 26 Jan 2021 08:18:00 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
        by userp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 10Q8A6kC151446;
        Tue, 26 Jan 2021 08:17:58 GMT
Received: from userv0122.oracle.com (userv0122.oracle.com [156.151.31.75])
        by userp3030.oracle.com with ESMTP id 368wqw4b8h-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 26 Jan 2021 08:17:58 +0000
Received: from abhmp0006.oracle.com (abhmp0006.oracle.com [141.146.116.12])
        by userv0122.oracle.com (8.14.4/8.14.4) with ESMTP id 10Q8Hss5025124;
        Tue, 26 Jan 2021 08:17:54 GMT
Received: from kadam (/102.36.221.92)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Tue, 26 Jan 2021 00:17:54 -0800
Date:   Tue, 26 Jan 2021 11:17:45 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     Carlis <zhangxuezhi3@gmail.com>
Cc:     gregkh@linuxfoundation.org, devel@driverdev.osuosl.org,
        linux-fbdev@vger.kernel.org, mh12gx2825@gmail.com,
        oliver.graute@kococonnector.com, linux-kernel@vger.kernel.org,
        dri-devel@lists.freedesktop.org, sbrivio@redhat.com,
        colin.king@canonical.com, zhangxuezhi1@yulong.com
Subject: Re: [PATCH v2] fbtft: add tearing signal detect
Message-ID: <20210126081745.GX2696@kadam>
References: <1611564252-84205-1-git-send-email-zhangxuezhi3@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1611564252-84205-1-git-send-email-zhangxuezhi3@gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9875 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 spamscore=0 phishscore=0
 adultscore=0 mlxlogscore=999 malwarescore=0 suspectscore=0 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2009150000
 definitions=main-2101260042
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9875 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 adultscore=0
 lowpriorityscore=0 mlxlogscore=999 clxscore=1015 phishscore=0 bulkscore=0
 spamscore=0 priorityscore=1501 mlxscore=0 suspectscore=0 impostorscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2009150000
 definitions=main-2101260042
Precedence: bulk
List-ID: <linux-fbdev.vger.kernel.org>
X-Mailing-List: linux-fbdev@vger.kernel.org

On Mon, Jan 25, 2021 at 04:44:12PM +0800, Carlis wrote:
> From: "carlis.zhang_cp" <zhangxuezhi1@yulong.com>

I was really expecting that you would fix this and Signed-off-by as
well.

regards,
dan carpenter

