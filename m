Return-Path: <linux-fbdev-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 02435C433DB
	for <linux-fbdev@archiver.kernel.org>; Wed, 24 Mar 2021 04:52:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id ADA3161993
	for <linux-fbdev@archiver.kernel.org>; Wed, 24 Mar 2021 04:52:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235217AbhCXEwW (ORCPT <rfc822;linux-fbdev@archiver.kernel.org>);
        Wed, 24 Mar 2021 00:52:22 -0400
Received: from smtprelay0001.hostedemail.com ([216.40.44.1]:48666 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S235216AbhCXEwV (ORCPT
        <rfc822;linux-fbdev@vger.kernel.org>);
        Wed, 24 Mar 2021 00:52:21 -0400
X-Greylist: delayed 544 seconds by postgrey-1.27 at vger.kernel.org; Wed, 24 Mar 2021 00:52:21 EDT
Received: from smtprelay.hostedemail.com (10.5.19.251.rfc1918.com [10.5.19.251])
        by smtpgrave03.hostedemail.com (Postfix) with ESMTP id 32E99180219CC
        for <linux-fbdev@vger.kernel.org>; Wed, 24 Mar 2021 04:43:18 +0000 (UTC)
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay07.hostedemail.com (Postfix) with ESMTP id B75B3181D303A;
        Wed, 24 Mar 2021 04:43:16 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-HE-Tag: wax59_1b1093527778
X-Filterd-Recvd-Size: 2080
Received: from [192.168.1.159] (unknown [47.151.137.21])
        (Authenticated sender: joe@perches.com)
        by omf09.hostedemail.com (Postfix) with ESMTPA;
        Wed, 24 Mar 2021 04:43:15 +0000 (UTC)
Message-ID: <c0eb61bee95906c1aef3631dcd95388957a229c7.camel@perches.com>
Subject: Re: [PATCH] video: mmp: Few typo fixes
From:   Joe Perches <joe@perches.com>
To:     Randy Dunlap <rdunlap@infradead.org>,
        Bhaskar Chowdhury <unixbhaskar@gmail.com>,
        dri-devel@lists.freedesktop.org, linux-fbdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
Date:   Tue, 23 Mar 2021 21:43:14 -0700
In-Reply-To: <30241dd5-dfd5-ec67-569b-1552bef58e95@infradead.org>
References: <20210322130210.3641181-1-unixbhaskar@gmail.com>
         <30241dd5-dfd5-ec67-569b-1552bef58e95@infradead.org>
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.38.1-1 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fbdev.vger.kernel.org>
X-Mailing-List: linux-fbdev@vger.kernel.org

On Mon, 2021-03-22 at 12:36 -0700, Randy Dunlap wrote:
> On 3/22/21 6:02 AM, Bhaskar Chowdhury wrote:
> > 
> > s/configed/configured/
> > s/registed/registered/
> > s/defintions/definitions/
> > 
> > Signed-off-by: Bhaskar Chowdhury <unixbhaskar@gmail.com>
> 
> Acked-by: Randy Dunlap <rdunlap@infradead.org>
[]
> > diff --git a/include/video/mmp_disp.h b/include/video/mmp_disp.h
> > index 77252cb46361..ea8b4331b7a1 100644
> > --- a/include/video/mmp_disp.h
> > +++ b/include/video/mmp_disp.h
> > @@ -172,7 +172,7 @@ struct mmp_panel {
> >  	/* use node to register to list */
> >  	struct list_head node;
> >  	const char *name;
> > -	/* path name used to connect to proper path configed */
> > +	/* path name used to connect to proper path configured */

The spelling is now correct, but the word order doesn't make much sense.

> > @@ -291,7 +291,7 @@ static inline int mmp_overlay_set_addr(struct mmp_overlay *overlay,
> >   * it defined a common interface that plat driver need to implement
> >   */
> >  struct mmp_path_info {
> > -	/* driver data, set when registed*/
> > +	/* driver data, set when registered*/

should have a space before */


