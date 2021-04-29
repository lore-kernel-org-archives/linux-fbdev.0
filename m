Return-Path: <linux-fbdev-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.5 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C6E6DC433B4
	for <linux-fbdev@archiver.kernel.org>; Thu, 29 Apr 2021 14:43:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 92BE561446
	for <linux-fbdev@archiver.kernel.org>; Thu, 29 Apr 2021 14:43:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232820AbhD2On5 (ORCPT <rfc822;linux-fbdev@archiver.kernel.org>);
        Thu, 29 Apr 2021 10:43:57 -0400
Received: from aserp2130.oracle.com ([141.146.126.79]:38088 "EHLO
        aserp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232816AbhD2On5 (ORCPT
        <rfc822;linux-fbdev@vger.kernel.org>);
        Thu, 29 Apr 2021 10:43:57 -0400
Received: from pps.filterd (aserp2130.oracle.com [127.0.0.1])
        by aserp2130.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 13TEcpRC170468;
        Thu, 29 Apr 2021 14:42:56 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=corp-2020-01-29;
 bh=0TxSLY2kK7MRYTK3OCHRP+D+iyiLTYfTm+JrDkZiRAo=;
 b=RaDqu3/sPl10o4gzt+6L/q9Zc3rm2lM/kSHtQzetaHGVDP9XlObX15NNDL1gWs7iAM9Y
 NI1p7sc0FiRIk5tRsn+/CnQZFt7kBWbyVGJqUmpnpjLP8SHCFFV7Rv1kZKzOqpnhjkH9
 VcvmnjgWsg05xuMO3iUQq4ZQ8wE/mPM4CA5004rdtQTYD/veC3kgeXhFsLSMNDrM4Ogp
 LIs/em2WTvR6oY65gRbOVc/cn+CaVpZozNcl1EsOkWPH3KNEAFarVcKSaiZZ8X7DonCl
 Qcl5urAs5T9c3bu8fiZ5f/pstjAbAQxO1xAMI19lzDwh2wu1Nxv/8459oeQUx/KVX0gQ Zg== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
        by aserp2130.oracle.com with ESMTP id 385afq4pmk-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 29 Apr 2021 14:42:55 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
        by userp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 13TEYvFc142941;
        Thu, 29 Apr 2021 14:42:55 GMT
Received: from pps.reinject (localhost [127.0.0.1])
        by userp3030.oracle.com with ESMTP id 3848f16duu-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 29 Apr 2021 14:42:55 +0000
Received: from userp3030.oracle.com (userp3030.oracle.com [127.0.0.1])
        by pps.reinject (8.16.0.36/8.16.0.36) with SMTP id 13TEeBXe167217;
        Thu, 29 Apr 2021 14:42:54 GMT
Received: from aserv0122.oracle.com (aserv0122.oracle.com [141.146.126.236])
        by userp3030.oracle.com with ESMTP id 3848f16du8-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 29 Apr 2021 14:42:54 +0000
Received: from abhmp0019.oracle.com (abhmp0019.oracle.com [141.146.116.25])
        by aserv0122.oracle.com (8.14.4/8.14.4) with ESMTP id 13TEgp3s016029;
        Thu, 29 Apr 2021 14:42:52 GMT
Received: from kadam (/102.36.221.92)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Thu, 29 Apr 2021 07:42:50 -0700
Date:   Thu, 29 Apr 2021 17:42:44 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     Phil Reid <preid@electromag.com.au>,
        dri-devel@lists.freedesktop.org, linux-fbdev@vger.kernel.org,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Re: [PATCH v3 3/4] staging: fbtft: Don't spam logs when probe is
 deferred
Message-ID: <20210429144244.GE1981@kadam>
References: <20210428130415.55406-1-andriy.shevchenko@linux.intel.com>
 <20210428130415.55406-4-andriy.shevchenko@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210428130415.55406-4-andriy.shevchenko@linux.intel.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Proofpoint-ORIG-GUID: vRDhrSXBtS_W24wT_EvXu4bM1w9PI0VE
X-Proofpoint-GUID: vRDhrSXBtS_W24wT_EvXu4bM1w9PI0VE
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9969 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 spamscore=0 phishscore=0
 clxscore=1011 suspectscore=0 lowpriorityscore=0 mlxlogscore=999 mlxscore=0
 adultscore=0 malwarescore=0 impostorscore=0 priorityscore=1501
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2104060000
 definitions=main-2104290095
Precedence: bulk
List-ID: <linux-fbdev.vger.kernel.org>
X-Mailing-List: linux-fbdev@vger.kernel.org

On Wed, Apr 28, 2021 at 04:04:14PM +0300, Andy Shevchenko wrote:
> @@ -75,20 +75,16 @@ static int fbtft_request_one_gpio(struct fbtft_par *par,
>  				  struct gpio_desc **gpiop)
>  {
>  	struct device *dev = par->info->device;
> -	int ret = 0;
>  
>  	*gpiop = devm_gpiod_get_index_optional(dev, name, index,
>  					       GPIOD_OUT_LOW);
> -	if (IS_ERR(*gpiop)) {
> -		ret = PTR_ERR(*gpiop);
> -		dev_err(dev,
> -			"Failed to request %s GPIO: %d\n", name, ret);
> -		return ret;
> -	}
> +	if (IS_ERR(*gpiop))
> +		dev_err_probe(dev, PTR_ERR(*gpiop), "Failed to request %s GPIO\n", name);

This should be a return statement:

		return dev_err_probe(dev, PTR_ERR(*gpiop), "Failed to request %s GPIO\n", name);

> +
>  	fbtft_par_dbg(DEBUG_REQUEST_GPIOS, par, "%s: '%s' GPIO\n",
>  		      __func__, name);
>  
> -	return ret;
> +	return 0;
>  }

regards,
dan carpenter

