From: "Antonino A. Daplas" <adaplas@hotpop.com>
Subject: Re: [PATCH 3/3] [FBDEV]: Hardware State Notification
Date: Tue, 29 Jun 2004 06:48:03 +0800
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Message-ID: <200406290645.11510.adaplas@hotpop.com>
References: <200406220639.26576.adaplas@hotpop.com> <200406250446.47073.adaplas@hotpop.com> <1088460578.15069.24.camel@gaston>
Reply-To: adaplas@pol.net
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11] helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1Bf4v8-00074X-QX
	for linux-fbdev-devel@lists.sourceforge.net; Mon, 28 Jun 2004 15:48:14 -0700
Received: from babyruth.hotpop.com ([38.113.3.61])
	by sc8-sf-mx1.sourceforge.net with esmtp (Exim 4.34)
	id 1Bf4v8-0006I3-BL
	for linux-fbdev-devel@lists.sourceforge.net; Mon, 28 Jun 2004 15:48:14 -0700
Received: from hotpop.com (kubrick.hotpop.com [38.113.3.103])
	by babyruth.hotpop.com (Postfix) with SMTP id AFCBE67B2E2
	for <linux-fbdev-devel@lists.sourceforge.net>; Mon, 28 Jun 2004 22:06:36 +0000 (UTC)
In-Reply-To: <1088460578.15069.24.camel@gaston>
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
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: James Simmons <jsimmons@infradead.org>, Andrew Morton <akpm@osdl.org>, Linux Fbdev development list <linux-fbdev-devel@lists.sourceforge.net>

On Tuesday 29 June 2004 06:09, Benjamin Herrenschmidt wrote:
> > Include nvidia into the list.  With the nv driver, the whole machine
> > hangs. The i810 has cursor sprite corruption, but has a workaround for
> > it.
> >
> > So, I would still like to do the set_par as late as possible such as in
> > fbcon_switch().  (BTW, this fixes the riva driver)
>
> Except that you may not have a switch, if for example an app switch to
> KD_GRAPHICS, do stuff with the engine, then back to KD_TEXT on the
> same console...
>

fbcon_switch() will be called when there is a request to redraw the screen 
of the same vc, such as in the above, or when switching to a different vc. 

I think the name 'con_switch' is misleading.  The better term, IMO, is
'con_redraw'.

Tony  




-------------------------------------------------------
This SF.Net email sponsored by Black Hat Briefings & Training.
Attend Black Hat Briefings & Training, Las Vegas July 24-29 - 
digital self defense, top technical experts, no vendor pitches, 
unmatched networking opportunities. Visit www.blackhat.com
