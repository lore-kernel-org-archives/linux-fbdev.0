Return-Path: <linux-fbdev-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	UNPARSEABLE_RELAY,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EC8BFC433ED
	for <linux-fbdev@archiver.kernel.org>; Sat,  8 May 2021 09:51:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BF54660FE9
	for <linux-fbdev@archiver.kernel.org>; Sat,  8 May 2021 09:51:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229797AbhEHJwZ (ORCPT <rfc822;linux-fbdev@archiver.kernel.org>);
        Sat, 8 May 2021 05:52:25 -0400
Received: from userp2120.oracle.com ([156.151.31.85]:54504 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229583AbhEHJwY (ORCPT
        <rfc822;linux-fbdev@vger.kernel.org>); Sat, 8 May 2021 05:52:24 -0400
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
        by userp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 1489jNfo086216;
        Sat, 8 May 2021 09:51:16 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=corp-2020-01-29;
 bh=K2d6P/2ARTEkgq+p8bLJPDn6+xepZan8ohLBIMdZjU4=;
 b=e2fF2mEbjVSoUg50UW40bGXZ8682tC1GmOm333t6hC6A24FEEaT7UsiPTs0aGG2fTUry
 FxrHcR9R7Gm1DFmQ6terf9LGjfXkgyr/QLAuTI+TBsYm1jzdHS+56JPIDbYeWbJ3llkB
 EnMsGT/4XR+Kc+u5XpddL3MYHwbnMi7A/Pgz5r6EZH+C5W/802m7VaY796JLeQZTTAGZ
 UpF/B5ZocXWuY5ykxfsATQkwkXeggc2JVY2UrEaUtDFBm655DQPbE1IaWdjbTZJqjkOA
 oTldDuC72tz6YvJvdALkOAvzdkMkfWSq5z3JVzJwrawi9sORqmvgvtdtG8GRE9RokC0E vg== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
        by userp2120.oracle.com with ESMTP id 38dk9n89v6-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sat, 08 May 2021 09:51:16 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
        by userp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 1489jQZc069875;
        Sat, 8 May 2021 09:51:16 GMT
Received: from pps.reinject (localhost [127.0.0.1])
        by userp3030.oracle.com with ESMTP id 38dfrs1kmp-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sat, 08 May 2021 09:51:16 +0000
Received: from userp3030.oracle.com (userp3030.oracle.com [127.0.0.1])
        by pps.reinject (8.16.0.36/8.16.0.36) with SMTP id 1489pFYw078445;
        Sat, 8 May 2021 09:51:16 GMT
Received: from userv0122.oracle.com (userv0122.oracle.com [156.151.31.75])
        by userp3030.oracle.com with ESMTP id 38dfrs1kmj-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sat, 08 May 2021 09:51:15 +0000
Received: from abhmp0007.oracle.com (abhmp0007.oracle.com [141.146.116.13])
        by userv0122.oracle.com (8.14.4/8.14.4) with ESMTP id 1489pD4L009195;
        Sat, 8 May 2021 09:51:13 GMT
Received: from kadam (/102.36.221.92)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Sat, 08 May 2021 02:51:13 -0700
Date:   Sat, 8 May 2021 12:51:06 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     Pavle Rohalj <pavle.rohalj@gmail.com>
Cc:     sudipm.mukherjee@gmail.com, teddy.wang@siliconmotion.com,
        gregkh@linuxfoundation.org, linux-fbdev@vger.kernel.org,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 09/49] staging: sm750fb: Rename sm750_set_power_mode
 function parameter
Message-ID: <20210508095106.GL1955@kadam>
References: <cover.1617776878.git.pavle.rohalj@gmail.com>
 <39375dd8cf48aabdc30c6bca67adc38887fd03cf.1617776878.git.pavle.rohalj@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <39375dd8cf48aabdc30c6bca67adc38887fd03cf.1617776878.git.pavle.rohalj@gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Proofpoint-ORIG-GUID: 2ltUN25n4oIsF7t0gyMnW9gt8sqODGfU
X-Proofpoint-GUID: 2ltUN25n4oIsF7t0gyMnW9gt8sqODGfU
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9977 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 phishscore=0
 adultscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 lowpriorityscore=0
 malwarescore=0 priorityscore=1501 clxscore=1015 bulkscore=0 spamscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2104190000
 definitions=main-2105080070
Precedence: bulk
List-ID: <linux-fbdev.vger.kernel.org>
X-Mailing-List: linux-fbdev@vger.kernel.org

On Tue, Apr 06, 2021 at 11:36:21PM -0700, Pavle Rohalj wrote:
> Fix "Avoid CamelCase" checkpatch.pl check for the function parameter
> powerMode of function sm750_set_power_mode.
> 
> Signed-off-by: Pavle Rohalj <pavle.rohalj@gmail.com>
> ---
>  drivers/staging/sm750fb/ddk750_power.h | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/staging/sm750fb/ddk750_power.h b/drivers/staging/sm750fb/ddk750_power.h
> index 4756db1ccb9c..d43942d6a5aa 100644
> --- a/drivers/staging/sm750fb/ddk750_power.h
> +++ b/drivers/staging/sm750fb/ddk750_power.h
> @@ -15,7 +15,7 @@ enum dpms {
>  }
>  
>  void ddk750_set_dpms(enum dpms state);
> -void sm750_set_power_mode(unsigned int powerMode);
> +void sm750_set_power_mode(unsigned int power_mode);

This should just be "mode" to match the function.

Anyway, I just realized now that I'm somehow reviewing ancient patches
so I'm going to stop.

regards,
dan carpenter

