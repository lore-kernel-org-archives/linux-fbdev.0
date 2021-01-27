Return-Path: <linux-fbdev-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.6 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8B905C433E0
	for <linux-fbdev@archiver.kernel.org>; Wed, 27 Jan 2021 06:53:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3B48D20724
	for <linux-fbdev@archiver.kernel.org>; Wed, 27 Jan 2021 06:53:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232027AbhA0GxF (ORCPT <rfc822;linux-fbdev@archiver.kernel.org>);
        Wed, 27 Jan 2021 01:53:05 -0500
Received: from aserp2120.oracle.com ([141.146.126.78]:48730 "EHLO
        aserp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231718AbhA0Guq (ORCPT
        <rfc822;linux-fbdev@vger.kernel.org>);
        Wed, 27 Jan 2021 01:50:46 -0500
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
        by aserp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 10R6YkXW057541;
        Wed, 27 Jan 2021 06:49:37 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=corp-2020-01-29;
 bh=CqKgGiA31ji91JUfrA7K3WTvBvHQ8ukOtwEdhs1EEDw=;
 b=FRJllVEcgIeqK8IzvXV0Zyx1WAscgHQdYzfmIxOi7hF8n2wHMiWU7m0itnt2bfVtwED8
 c1KE/NPGCgCyMtXTmAdlKwSmyJa6QbJDS3xfNBxk1DM46Rg50PZErobGDj3MDqjs/N+3
 L5c4FK18i13s28KUwKi56p9+VJmzfTiSFV0UX8DeAaAEv5+bKzrE61BLDYNV8LvzDUeH
 T+bq6ymxU2X9z3s7vJjeWFFxfRf3SDP+OPpgpgtQt1gWz/JSw62xuvzFz7Wf0IUrn42Q
 zr/L1FD0K8m77AZ2NWQOcqzjqMu+l5qWTnO7r2TjENzBZtyrBYzssSndJiP8TUUgp3Hk 0Q== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
        by aserp2120.oracle.com with ESMTP id 368brkndkq-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 27 Jan 2021 06:49:37 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
        by aserp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 10R6Z6EP099786;
        Wed, 27 Jan 2021 06:49:35 GMT
Received: from userv0121.oracle.com (userv0121.oracle.com [156.151.31.72])
        by aserp3030.oracle.com with ESMTP id 368wcnvup1-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 27 Jan 2021 06:49:35 +0000
Received: from abhmp0015.oracle.com (abhmp0015.oracle.com [141.146.116.21])
        by userv0121.oracle.com (8.14.4/8.13.8) with ESMTP id 10R6nP7f003592;
        Wed, 27 Jan 2021 06:49:25 GMT
Received: from kadam (/102.36.221.92)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Tue, 26 Jan 2021 22:49:24 -0800
Date:   Wed, 27 Jan 2021 09:49:16 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     carlis <zhangxuezhi3@gmail.com>
Cc:     devel@driverdev.osuosl.org, linux-fbdev@vger.kernel.org,
        mh12gx2825@gmail.com, gregkh@linuxfoundation.org,
        oliver.graute@kococonnector.com, linux-kernel@vger.kernel.org,
        dri-devel@lists.freedesktop.org, sbrivio@redhat.com,
        colin.king@canonical.com, zhangxuezhi1@yulong.com
Subject: Re: [PATCH v5] fbtft: add tearing signal detect
Message-ID: <20210127064916.GD2696@kadam>
References: <1611711140-68260-1-git-send-email-zhangxuezhi3@gmail.com>
 <20210127054523.GA2696@kadam>
 <20210127141927.00004472@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210127141927.00004472@gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9876 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 mlxscore=0 suspectscore=0
 phishscore=0 mlxlogscore=999 bulkscore=0 malwarescore=0 spamscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2009150000
 definitions=main-2101270037
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9876 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 impostorscore=0
 phishscore=0 bulkscore=0 priorityscore=1501 mlxlogscore=999
 lowpriorityscore=0 spamscore=0 mlxscore=0 suspectscore=0 malwarescore=0
 clxscore=1015 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2101270037
Precedence: bulk
List-ID: <linux-fbdev.vger.kernel.org>
X-Mailing-List: linux-fbdev@vger.kernel.org

On Wed, Jan 27, 2021 at 02:19:27PM +0800, carlis wrote:
> hi,i will fix it like below:
> 	par->gpio.te = devm_gpiod_get_index_optional(dev, "te", 0,
> GPIOD_IN); if (IS_ERR(par->gpio.te)) {
> 		rc = PTR_ERR(par->gpio.te);
> 		pr_err("Failed to request  te gpio: %d\n", rc);
> 		par->gpio.te = NULL;
> 	}

I wish you would just copy and paste the code that I sent you instead,
but this also fixes the crash...

regards,
dan carpenter


