Return-Path: <linux-fbdev-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.5 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 330E2C433E6
	for <linux-fbdev@archiver.kernel.org>; Thu, 28 Jan 2021 15:27:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DFCEA64DF3
	for <linux-fbdev@archiver.kernel.org>; Thu, 28 Jan 2021 15:27:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232372AbhA1P1C (ORCPT <rfc822;linux-fbdev@archiver.kernel.org>);
        Thu, 28 Jan 2021 10:27:02 -0500
Received: from userp2130.oracle.com ([156.151.31.86]:34456 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231875AbhA1P1A (ORCPT
        <rfc822;linux-fbdev@vger.kernel.org>);
        Thu, 28 Jan 2021 10:27:00 -0500
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
        by userp2130.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 10SFJuIQ118435;
        Thu, 28 Jan 2021 15:26:09 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : mime-version : content-type :
 content-transfer-encoding : in-reply-to; s=corp-2020-01-29;
 bh=2gLXiKCgRSS7kTFwCYui5MzR6pPKfBNKiPKEY7OQMgY=;
 b=gXPKERt+Fh24YexAqdwWgz3yhxChk94LGX69wA793D+trr/TxxloojLJnSyA1RsPXAkx
 StsSDCcYK1Wlef9js1oC27V4MOyz+/YqYazJZ7KtSkrgfyOxx61wrC55KA4NKf3MdYkJ
 udMvFA3iwbEz7cf6KrCQy33px8mJDTmXzedBYXl2PIHdA5cCB3j8vZyxjlvEks8ShR41
 OXkcmdVMsbOtYgUrfisN5ComUBjSkr5noqKvUOo2+GB/uEOIz9i7YxKHQU9uomZvW6Im
 rEartVXsyEFV7bz/imqdDxA3n9Z0V9NnIJBXJpDO5rW+EMwxDeemMkf1aWFKhrQPwDzQ dA== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
        by userp2130.oracle.com with ESMTP id 368b7r4pg9-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 28 Jan 2021 15:26:09 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
        by userp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 10SFJqP9134457;
        Thu, 28 Jan 2021 15:24:07 GMT
Received: from userv0122.oracle.com (userv0122.oracle.com [156.151.31.75])
        by userp3020.oracle.com with ESMTP id 368wju6y2h-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 28 Jan 2021 15:24:07 +0000
Received: from abhmp0018.oracle.com (abhmp0018.oracle.com [141.146.116.24])
        by userv0122.oracle.com (8.14.4/8.14.4) with ESMTP id 10SFO21G020707;
        Thu, 28 Jan 2021 15:24:02 GMT
Received: from kadam (/102.36.221.92)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Thu, 28 Jan 2021 07:24:01 -0800
Date:   Thu, 28 Jan 2021 18:23:52 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     Andy Shevchenko <andy.shevchenko@gmail.com>
Cc:     Carlis <zhangxuezhi3@gmail.com>,
        "open list:STAGING SUBSYSTEM" <devel@driverdev.osuosl.org>,
        "open list:FRAMEBUFFER LAYER" <linux-fbdev@vger.kernel.org>,
        Deepak R Varma <mh12gx2825@gmail.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        oliver.graute@kococonnector.com,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        Stefano Brivio <sbrivio@redhat.com>,
        Colin King <colin.king@canonical.com>, zhangxuezhi1@yulong.com
Subject: Re: [PATCH v12] staging: fbtft: add tearing signal detect
Message-ID: <20210128152352.GH2696@kadam>
References: <1611838435-151774-1-git-send-email-zhangxuezhi3@gmail.com>
 <CAHp75Vd=ijxnamuSYuxNLeyhGMCod=HaXWrQ0W0+3QCsQAychg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAHp75Vd=ijxnamuSYuxNLeyhGMCod=HaXWrQ0W0+3QCsQAychg@mail.gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Proofpoint-IMR: 1
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9877 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 suspectscore=0
 adultscore=0 mlxscore=0 malwarescore=0 spamscore=0 mlxlogscore=999
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2101280079
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9877 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 spamscore=0 phishscore=0
 adultscore=0 impostorscore=0 malwarescore=0 lowpriorityscore=0 bulkscore=0
 priorityscore=1501 mlxscore=0 clxscore=1011 mlxlogscore=999
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2009150000
 definitions=main-2101280079
Precedence: bulk
List-ID: <linux-fbdev.vger.kernel.org>
X-Mailing-List: linux-fbdev@vger.kernel.org

On Thu, Jan 28, 2021 at 04:33:02PM +0200, Andy Shevchenko wrote:
> > +               init_completion(&spi_panel_te);
> > +               rc = devm_request_irq(dev,
> 
> > +                                     gpiod_to_irq(par->gpio.te),
> 
> ...and here simply use irq.
> 
> > +                                    spi_panel_te_handler, IRQF_TRIGGER_RISING,
> > +                                    "TE_GPIO", par);
> 
> > +               if (IS_ERR(rc))
> 
> This is wrong. rc is integer no IS_ERR() is required. Ditto for
> PTR_ERR(). Have you even looked for these macros implementations?
> 

Yeah...  It leads to a compile warning:

	warning: passing argument 1 of ‘IS_ERR’ makes pointer from integer without a cast [-Wint-conversion]

regards,
dan carpenter

