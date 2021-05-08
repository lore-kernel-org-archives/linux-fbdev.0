Return-Path: <linux-fbdev-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	UNPARSEABLE_RELAY,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 15F08C433B4
	for <linux-fbdev@archiver.kernel.org>; Sat,  8 May 2021 09:44:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E36ED61424
	for <linux-fbdev@archiver.kernel.org>; Sat,  8 May 2021 09:44:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229797AbhEHJpr (ORCPT <rfc822;linux-fbdev@archiver.kernel.org>);
        Sat, 8 May 2021 05:45:47 -0400
Received: from aserp2130.oracle.com ([141.146.126.79]:33062 "EHLO
        aserp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229583AbhEHJpq (ORCPT
        <rfc822;linux-fbdev@vger.kernel.org>); Sat, 8 May 2021 05:45:46 -0400
Received: from pps.filterd (aserp2130.oracle.com [127.0.0.1])
        by aserp2130.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 1489iWBS019624;
        Sat, 8 May 2021 09:44:32 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=corp-2020-01-29;
 bh=+7ZZyYeUYy9IQ3ZxTjAWfnpZ4ty+iYLlka/hAfiNP4U=;
 b=IFce8VSQZEA2AAnfDoQWgi7u7nQeClHrqAsEhnZvR8cwkDtMg7HaWsi/8cs54RViMSjv
 HE6GsNm7ThtDlcvVzyFv7aR4NkoPZQUi3P4HkZoHUCUE8oYem1Q+2TIS/wN4uujjq2uU
 ZTFwBY6ZNiv9NVcJXE8KES9VjJ+zlSmLd7SYM5J6LRyWUgcasW8jfmCJxezqLQ8wmraN
 1e05dEOqVkTrDxRRaLFkjQkWk4yEjNa4n4RH/kp2jNTwwBw5/Wwpv6nc68zai1qQNnlU
 3wy7d1EwLSVFfdePqykkp9hvc63Zqni6HxLeWJDP8KiaaNXe7WA45w6BCs+DGEal5Nmj Rw== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
        by aserp2130.oracle.com with ESMTP id 38dg5b8djg-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sat, 08 May 2021 09:44:32 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
        by aserp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 1489iUoF179553;
        Sat, 8 May 2021 09:44:32 GMT
Received: from pps.reinject (localhost [127.0.0.1])
        by aserp3020.oracle.com with ESMTP id 38djf0uadg-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sat, 08 May 2021 09:44:32 +0000
Received: from aserp3020.oracle.com (aserp3020.oracle.com [127.0.0.1])
        by pps.reinject (8.16.0.36/8.16.0.36) with SMTP id 1489iVcf179564;
        Sat, 8 May 2021 09:44:31 GMT
Received: from aserv0122.oracle.com (aserv0122.oracle.com [141.146.126.236])
        by aserp3020.oracle.com with ESMTP id 38djf0uadd-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sat, 08 May 2021 09:44:31 +0000
Received: from abhmp0018.oracle.com (abhmp0018.oracle.com [141.146.116.24])
        by aserv0122.oracle.com (8.14.4/8.14.4) with ESMTP id 1489iTfm005380;
        Sat, 8 May 2021 09:44:29 GMT
Received: from kadam (/102.36.221.92)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Sat, 08 May 2021 02:44:28 -0700
Date:   Sat, 8 May 2021 12:43:50 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     Pavle Rohalj <pavle.rohalj@gmail.com>
Cc:     sudipm.mukherjee@gmail.com, teddy.wang@siliconmotion.com,
        gregkh@linuxfoundation.org, linux-fbdev@vger.kernel.org,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 02/49] staging: sm750fb: Rename dviInit to dvi_init
 and update param names
Message-ID: <20210508094350.GJ1955@kadam>
References: <cover.1617776878.git.pavle.rohalj@gmail.com>
 <6c6ecf7eee7d41492dbbcc4410db7eefd1fbb13d.1617776878.git.pavle.rohalj@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6c6ecf7eee7d41492dbbcc4410db7eefd1fbb13d.1617776878.git.pavle.rohalj@gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Proofpoint-GUID: TzmPJEEHRRvF5WfjN67V6i6ygZ5sj5wF
X-Proofpoint-ORIG-GUID: TzmPJEEHRRvF5WfjN67V6i6ygZ5sj5wF
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9977 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 lowpriorityscore=0 malwarescore=0
 bulkscore=0 spamscore=0 clxscore=1011 priorityscore=1501 adultscore=0
 mlxlogscore=999 mlxscore=0 suspectscore=0 impostorscore=0 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2104190000
 definitions=main-2105080070
Precedence: bulk
List-ID: <linux-fbdev.vger.kernel.org>
X-Mailing-List: linux-fbdev@vger.kernel.org

On Tue, Apr 06, 2021 at 11:36:01PM -0700, Pavle Rohalj wrote:
> Fix "Avoid CamelCase" checkpatch.pl checks for the function dviInit and
> its parameter names in ddk750_dvi.h.
> 
> Signed-off-by: Pavle Rohalj <pavle.rohalj@gmail.com>
> ---
>  drivers/staging/sm750fb/ddk750_dvi.c |  2 +-
>  drivers/staging/sm750fb/ddk750_dvi.h | 20 ++++++++++----------
>  2 files changed, 11 insertions(+), 11 deletions(-)
> 
> diff --git a/drivers/staging/sm750fb/ddk750_dvi.c b/drivers/staging/sm750fb/ddk750_dvi.c
> index db19bf732482..943cbcafcffa 100644
> --- a/drivers/staging/sm750fb/ddk750_dvi.c
> +++ b/drivers/staging/sm750fb/ddk750_dvi.c
> @@ -30,7 +30,7 @@ static struct dvi_ctrl_device dcft_supported_dvi_controller[] = {
>  #endif
>  };
>  
> -int dviInit(unsigned char edge_select,
> +int dvi_init(unsigned char edge_select,
>  	    unsigned char bus_select,
>  	    unsigned char dual_edge_clk_select,
>  	    unsigned char hsync_enable,

The fact that you were able to change this without changing any callers
suggests that this is not used.  In that case, just delete it instead
of renaming it.

regards,
dan carpenter

