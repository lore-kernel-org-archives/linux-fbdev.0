From: Lucas Correia Villa Real <lucasvr@gobolinux.org>
Subject: Re: doubts
Date: Fri, 28 May 2004 00:44:24 -0300
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Message-ID: <200405280044.24185.lucasvr@gobolinux.org>
References: <000001c44316$487bf040$7c04b40a@dlh.st.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11] helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1BTYHO-0002Uu-Ru
	for linux-fbdev-devel@lists.sourceforge.net; Thu, 27 May 2004 20:43:34 -0700
Received: from loncoche.terra.com.br ([200.154.55.229])
	by sc8-sf-mx1.sourceforge.net with esmtp (Exim 4.30)
	id 1BTYHO-0000ik-A7
	for linux-fbdev-devel@lists.sourceforge.net; Thu, 27 May 2004 20:43:34 -0700
Received: from arica.terra.com.br (arica.terra.com.br [200.154.55.128])
	by loncoche.terra.com.br (Postfix) with ESMTP id 324BDE784B5
	for <linux-fbdev-devel@lists.sourceforge.net>; Fri, 28 May 2004 00:43:28 -0300 (BRT)
Received: from ummagumma.ozzmosis.net (200-203-051-011.nhoce7002.dsl.brasiltelecom.net.br [200.203.51.11])
	(authenticated user lucasvr)
	by arica.terra.com.br (Postfix) with ESMTP id E64D33C00F
	for <linux-fbdev-devel@lists.sourceforge.net>; Fri, 28 May 2004 00:43:27 -0300 (BRT)
In-Reply-To: <000001c44316$487bf040$7c04b40a@dlh.st.com>
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
To: linux-fbdev-devel@lists.sourceforge.net

On Wednesday 26 May 2004 08:40, Manish RATHI wrote:
> Hi,
> In franebuffer  fb_info structure, there are 4 functions to be used by
> fbcon.c these are:

4? You asked for 3 functions :-)


> (*updatevar)();

This is a function called by fbcon.c when going to update a user defined part 
of the display, in order to pan/wrap; updatevar() usually sets the new 
driver's "var" xoffset and yoffset and then tells the video controller the 
new screen start address. 


> (*changevar)();

Oh, I didn't see any driver using that. In the case of fbcon_changevar, it 
just calls fbcon_setup (specifying not to show the logo again), which resets 
the framebuffer settings such as font and pan/wrap offsets. 

When one calls (*setvar)(), which modifies the display variable configuration, 
it checks for the existence of a non-null function pointer to changevar and 
if found, calls that function. I really don't know why a driver should need 
to restart things when changing var data. Could anyone help to clarify that?

> (*blank)();

This function does the screen blanking routine, not required to be implemented 
by the driver. There's a good explanation of it on skeletonfb.c.


> Could anybody tell me the logic of above functions. Although they are
> mentioned in pl110.c and vfb.c but only function header is given.
>
>
> Regards
> Manish

Cheers,
Lucas


-------------------------------------------------------
This SF.Net email is sponsored by: Oracle 10g
Get certified on the hottest thing ever to hit the market... Oracle 10g. 
Take an Oracle 10g class now, and we'll give you the exam FREE.
http://ads.osdn.com/?ad_id=3149&alloc_id=8166&op=click
