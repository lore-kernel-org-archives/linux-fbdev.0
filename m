From: "Jordan Crouse" <jordan.crouse@amd.com>
Subject: Re: fb: modedb uses wrong default_mode
Date: Wed, 15 Nov 2006 16:44:56 -0700
Message-ID: <20061115234456.GB3674@cosmic.amd.com>
References: <Pine.LNX.4.64.0611151933070.12799@jalava.cc.jyu.fi>
	<20061115152952.0e92c50d.akpm@osdl.org>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1GkUP4-0008PY-61 for linux-fbdev-devel@lists.sourceforge.net;
	Wed, 15 Nov 2006 15:42:50 -0800
Received: from outbound-ash.frontbridge.com ([206.16.192.249]
	helo=outbound2-ash-R.bigfish.com)
	by mail.sourceforge.net with esmtps (TLSv1:DES-CBC3-SHA:168)
	(Exim 4.44) id 1GkUP0-00022K-Lh
	for linux-fbdev-devel@lists.sourceforge.net;
	Wed, 15 Nov 2006 15:42:50 -0800
In-Reply-To: <20061115152952.0e92c50d.akpm@osdl.org>
Content-Disposition: inline
List-Id: <fbdev-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=linux-fbdev-devel>
List-Post: <mailto:linux-fbdev-devel@lists.sourceforge.net>
List-Help: <mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=subscribe>
Sender: linux-fbdev-devel-bounces@lists.sourceforge.net
Errors-To: linux-fbdev-devel-bounces@lists.sourceforge.net
To: Andrew Morton <akpm@osdl.org>
Cc: linux-fbdev-devel@lists.sourceforge.net, Tero Roponen <teanropo@jyu.fi>, linux-kernel@vger.kernel.org

On 15/11/06 15:29 -0800, Andrew Morton wrote:
> On Wed, 15 Nov 2006 19:43:16 +0200 (EET)
> Tero Roponen <teanropo@jyu.fi> wrote:
> 
> > 
> > It seems that default_mode is always overwritten in
> > fb_find_mode() if caller gives its own modedb; this
> > patch should fix it.

> Sigh.
> 
> 2.6.19-rc5 has:
> 
>     if (!default_mode)
> 	default_mode = &modedb[DEFAULT_MODEDB_INDEX];
> 
> and Jordan changed it to
> 
>     if (!default_mode && db != modedb)
> 	default_mode = &db[0];
>     else
> 	default_mode = &modedb[DEFAULT_MODEDB_INDEX];


> and you want to change it to
> 
>     if (!default_mode && db != modedb)
> 	default_mode = &db[0];
>     else if (!default_mode)
> 	default_mode = &modedb[DEFAULT_MODEDB_INDEX];
> 
> which is actually a complicated way of doing
> 
>     if (!default_mode)
> 	default_mode = &db[DEFAULT_MODEDB_INDEX];

Unless DEFAULT_MODEDB_INDEX for some reason gets set to non-zero, then
it could be dangerous. If we agree that the default entry should aways be 
at 0, then nuke the define and hard code the zero.  That way, nobody will be 
tempted to change it.

Jordan

-- 
Jordan Crouse
Senior Linux Engineer
Advanced Micro Devices, Inc.
<www.amd.com/embeddedprocessors>



-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys - and earn cash
http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
