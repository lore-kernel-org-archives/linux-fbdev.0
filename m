Return-Path: <linux-fbdev-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ECA9EC433DB
	for <linux-fbdev@archiver.kernel.org>; Thu, 14 Jan 2021 09:05:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B4B9B239FF
	for <linux-fbdev@archiver.kernel.org>; Thu, 14 Jan 2021 09:05:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726806AbhANJFi (ORCPT <rfc822;linux-fbdev@archiver.kernel.org>);
        Thu, 14 Jan 2021 04:05:38 -0500
Received: from mga04.intel.com ([192.55.52.120]:64561 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727374AbhANJFg (ORCPT <rfc822;linux-fbdev@vger.kernel.org>);
        Thu, 14 Jan 2021 04:05:36 -0500
IronPort-SDR: lBLFtmIj4u337QFeAtqLOCSXE2ZkpNi0kUX8j3lDeutt11qhiR07u3bD9dofA6P4KnunuAvM6x
 qIeEURvrXOVw==
X-IronPort-AV: E=McAfee;i="6000,8403,9863"; a="175752841"
X-IronPort-AV: E=Sophos;i="5.79,346,1602572400"; 
   d="scan'208";a="175752841"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Jan 2021 01:04:42 -0800
IronPort-SDR: G8QGeNRrjTIX+UfYb2dYkwKbshkJZWnK/VbTJufU8URmutTPv10plPssRnoEi0mIXK3ALsiWcT
 DjXC4Fny/cWg==
X-IronPort-AV: E=Sophos;i="5.79,346,1602572400"; 
   d="scan'208";a="382199636"
Received: from dforourk-mobl1.ger.corp.intel.com (HELO localhost) ([10.213.254.146])
  by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Jan 2021 01:04:22 -0800
From:   Jani Nikula <jani.nikula@linux.intel.com>
To:     Lee Jones <lee.jones@linaro.org>, Sam Ravnborg <sam@ravnborg.org>
Cc:     "Eddie C. Dost" <ecd@skynet.be>, linux-fbdev@vger.kernel.org,
        Anthony Tong <atong@uiuc.edu>, Alex Kern <alex.kern@gmx.de>,
        dri-devel@lists.freedesktop.org, Oliver Kropp <dok@directfb.org>,
        Software Engineering <lg@denx.de>,
        Antonino Daplas <adaplas@pol.net>,
        Frodo Looijaard <frodol@dds.nl>,
        Steffen Trumtrar <s.trumtrar@pengutronix.de>,
        Urs Ganse <ursg@uni.de>,
        Thibaut VARENE <varenet@parisc-linux.org>,
        Florian Tobias Schandinat <FlorianSchandinat@gmx.de>,
        Evgeny Novikov <novikov@ispras.ru>,
        Helge Deller <deller@gmx.de>,
        Vaibhav Gupta <vaibhavgupta40@gmail.com>,
        Ani Joshi <ajoshi@unixbox.com>,
        Emmanuel Marty <core@ggi-project.org>,
        "Mark D. Studebaker" <mdsxyz123@yahoo.com>,
        Alex Dewar <alex.dewar90@gmail.com>,
        daniel.mantione@freepascal.org,
        Kristoffer Ericson <kristoffer.ericson@gmail.com>,
        carter@compsci.bristol.ac.uk, Alan Cox <alan@redhat.com>,
        Jeff Garzik <jgarzik@pobox.com>,
        Ilario Nardinocchi <nardinoc@cs.unibo.it>,
        Jakub Jelinek <jakub@redhat.com>,
        Ani Joshi <ajoshi@shell.unixbox.com>,
        "Thomas J. Moore" <dark@mama.indstate.edu>,
        Arnd Bergmann <arnd@arndb.de>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        John Fremlin <vii@users.sourceforge.net>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Thomas Winischhofer <thomas@winischhofer.net>,
        William Rucklidge <wjr@cs.cornell.edu>,
        Paul Mundt <lethal@chaoticdreams.org>,
        Brad Douglas <brad@neruo.com>,
        Ralph Metzler <rjkm@thp.uni-koeln.de>,
        James Simmons <jsimmons@users.sf.net>,
        Ghozlane Toumi <gtoumi@laposte.net>,
        Jim Hague <jim.hague@acm.org>,
        Egbert Eich <Egbert.Eich@physik.tu-darmstadt.de>,
        Jes Sorensen <jds@kom.auc.dk>,
        Gerd Knorr <kraxel@goldbach.in-berlin.de>,
        Jingoo Han <jingoohan1@gmail.com>,
        "Gustavo A. R. Silva" <gustavoars@kernel.org>,
        Martin Mares <mj@ucw.cz>, linux-kernel@vger.kernel.org,
        Ben Dooks <ben@simtec.co.uk>, Hannu Mallat <hmallat@cc.hut.fi>,
        Philip Edelbrock <phil@netroedge.com>,
        Jakub Jelinek <jj@ultra.linux.cz>,
        Mike Rapoport <rppt@kernel.org>
Subject: Re: [PATCH 00/31] Rid W=1 warnings from Video
In-Reply-To: <20210113202546.GG3975472@dell>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
References: <20210113145009.1272040-1-lee.jones@linaro.org> <20210113190118.GA180942@ravnborg.org> <20210113202546.GG3975472@dell>
Date:   Thu, 14 Jan 2021 11:04:19 +0200
Message-ID: <877dofriss.fsf@intel.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-fbdev.vger.kernel.org>
X-Mailing-List: linux-fbdev@vger.kernel.org

On Wed, 13 Jan 2021, Lee Jones <lee.jones@linaro.org> wrote:
> On Wed, 13 Jan 2021, Sam Ravnborg wrote:
>
>> Hi Lee,
>> 
>> On Wed, Jan 13, 2021 at 02:49:38PM +0000, Lee Jones wrote:
>> > This set is part of a larger effort attempting to clean-up W=1
>> > kernel builds, which are currently overwhelmingly riddled with
>> > niggly little warnings.
>> > 
>> > This patch-set clears all of the W=1 warnings currently residing
>> > in drivers/video.
>> 
>> I am sorry to say that I expect most of your nice patches to clash
>> with patches that is already present in drm-misc-next.
>> 
>> drivers/video/ are warning free with W=1 in drm-misc-next today.
>> 
>> I do not know why drm-misc-next is not yet pullled into linux-next.
>
> Well that kinda sucks.  What are the chances of that?
>
> Most of my patches fix issues that have been there for years!

We auto-update the for-linux-next and for-linux-next-fixes branches, and
they seem to be up-to-date [1].

How recent are the fixes, maybe because of this: [2]?

BR,
Jani.


[1] https://cgit.freedesktop.org/drm/drm-misc
[2] http://lore.kernel.org/r/20210114113107.622102e0@canb.auug.org.au

-- 
Jani Nikula, Intel Open Source Graphics Center
