From: "Antonino A. Daplas" <adaplas@hotpop.com>
Subject: Re: Fw: Rivafb I2C problem, new patch
Date: Wed, 14 Jul 2004 04:52:47 +0800
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Message-ID: <200407140452.49585.adaplas@hotpop.com>
References: <20040712163942.672d4047.akpm@osdl.org> <200407130958.15483.adaplas@hotpop.com> <1089712381.6181.20.camel@tom>
Reply-To: adaplas@pol.net
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.12] helo=sc8-sf-mx2.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1BkUHq-0005AP-SV
	for linux-fbdev-devel@lists.sourceforge.net; Tue, 13 Jul 2004 13:54:02 -0700
Received: from babyruth.hotpop.com ([38.113.3.61])
	by sc8-sf-mx2.sourceforge.net with esmtp (Exim 4.34)
	id 1BkUHq-0004UH-Hq
	for linux-fbdev-devel@lists.sourceforge.net; Tue, 13 Jul 2004 13:54:02 -0700
Received: from hotpop.com (kubrick.hotpop.com [38.113.3.103])
	by babyruth.hotpop.com (Postfix) with SMTP id E95066D6F94
	for <linux-fbdev-devel@lists.sourceforge.net>; Tue, 13 Jul 2004 20:08:07 +0000 (UTC)
In-Reply-To: <1089712381.6181.20.camel@tom>
Content-Disposition: inline
Errors-To: linux-fbdev-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Id: <fbdev-devel.lists.sourceforge.net>
List-Post: <mailto:linux-fbdev-devel@lists.sourceforge.net>
List-Help: <mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=linux-fbdev-devel>
Content-Type: text/plain; charset="us-ascii"
To: Nicolas Boichat <nicolas@boichat.ch>, adaplas@pol.net, Greg KH <greg@kroah.com>
Cc: Andrew Morton <akpm@osdl.org>, linux-fbdev-devel@lists.sourceforge.net

On Tuesday 13 July 2004 17:53, Nicolas Boichat wrote:
> Hello,
>
> Thanks for your answers.
>
> I attached a new patch: I deleted the lines that were commented out.
>

One thing I forgot, make sure it compiles when CONFIG_FB_RIVA_I2C is
set or not.

Tony




-------------------------------------------------------
This SF.Net email sponsored by Black Hat Briefings & Training.
Attend Black Hat Briefings & Training, Las Vegas July 24-29 - 
digital self defense, top technical experts, no vendor pitches, 
unmatched networking opportunities. Visit www.blackhat.com
