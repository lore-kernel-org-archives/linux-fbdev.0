From: "Alex Deucher" <alexdeucher@gmail.com>
Subject: Re: radeonfb monid i2c bus
Date: Fri, 6 Jun 2008 09:46:39 -0400
Message-ID: <a728f9f90806060646q23cf9974k9647a79e8894451@mail.gmail.com>
References: <20080606120151.7976df45@hyperion.delvare>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1K4cHB-0004zs-7C for linux-fbdev-devel@lists.sourceforge.net;
	Fri, 06 Jun 2008 06:46:41 -0700
Received: from rv-out-0708.google.com ([209.85.198.243])
	by mail.sourceforge.net with esmtp (Exim 4.44) id 1K4cH9-0006mo-UU
	for linux-fbdev-devel@lists.sourceforge.net;
	Fri, 06 Jun 2008 06:46:41 -0700
Received: by rv-out-0708.google.com with SMTP id f25so1089169rvb.22
	for <linux-fbdev-devel@lists.sourceforge.net>;
	Fri, 06 Jun 2008 06:46:39 -0700 (PDT)
In-Reply-To: <20080606120151.7976df45@hyperion.delvare>
Content-Disposition: inline
List-Id: <fbdev-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux-fbdev-devel>
List-Post: <mailto:linux-fbdev-devel@lists.sourceforge.net>
List-Help: <mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=subscribe>
Sender: linux-fbdev-devel-bounces@lists.sourceforge.net
Errors-To: linux-fbdev-devel-bounces@lists.sourceforge.net
To: Jean Delvare <khali@linux-fr.org>
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>, linux-fbdev-devel@lists.sourceforge.net

On Fri, Jun 6, 2008 at 6:01 AM, Jean Delvare <khali@linux-fr.org> wrote:
> Hi Ben,
>
> Can you explain what is the "monid" i2c bus on Radeon adapters? I have
> two Radeon chips here, an M6 in my old laptop and a 9200 in my desktop
> system. On the M6 there is nothing on the monid bus. On the 9200, the
> monid bus doesn't even work, every access results in timeout. The
> radeonfb driver doesn't even look for EDID EEPROMs on that bus (except
> in debug code.)
>
> So I'm curious why you create this i2c bus if you don't need it.
> Have you ever seen a Radeon adapter where there is something on that
> bus?

There are several i2c busses available on radeons and different OEMs
use different combinations.  The bus used by each display output is
listed in the connector table in the vbios rom on x86 cards.  Other
uses include controlling external TMDS or DAC chips on some cards.
This info is also available via the bios tables on x86 cards.

Alex

-------------------------------------------------------------------------
Check out the new SourceForge.net Marketplace.
It's the best place to buy or sell services for
just about anything Open Source.
http://sourceforge.net/services/buy/index.php
