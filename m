From: James Simmons <jsimmons@www.infradead.org>
Subject: Re: Ruby redux
Date: Mon, 21 Feb 2005 21:55:40 +0000 (GMT)
Message-ID: <Pine.LNX.4.56.0502212143030.16017@pentafluge.infradead.org>
References: <4218CCF0.5030803@freemail.hu>
Mime-Version: 1.0
In-Reply-To: <4218CCF0.5030803@freemail.hu>
Sender: linuxconsole-dev-admin@lists.sourceforge.net
Errors-To: linuxconsole-dev-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linuxconsole-dev>,
	<mailto:linuxconsole-dev-request@lists.sourceforge.net?subject=unsubscribe>
List-Id: <fbdev-devel.lists.sourceforge.net>
List-Post: <mailto:linuxconsole-dev@lists.sourceforge.net>
List-Help: <mailto:linuxconsole-dev-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linuxconsole-dev>,
	<mailto:linuxconsole-dev-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=linuxconsole-dev>
Content-Type: TEXT/PLAIN; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Zoltan Boszormenyi <zboszor@freemail.hu>
Cc: Linux console project <linuxconsole-dev@lists.sourceforge.net>, Aivils <aivils@unibanka.lv>, James Simmons <jsimmons@infradead.org>, Roman Zippel <zippel@linux-m68k.org>, Linux Fbdev development list <linux-fbdev-devel@lists.sourceforge.net>


> as large console cleanups went into the -mm tree and those cleanups
> are also part of the Ruby tree, I thought I look at the Ruby tree
> and port it to 2.6.11-rc4 + the following 4 patches:

Yeap. I talked to Andrew Morton and Christoph Hellwig about the patches.
The major difference is that struct vt_struct is removed completely. 
Chris told me we can add in struct vt_struct again at a later time.
Well he actually ask me to rename it to something else. The big patch 
which is really nice is the killing off of the console macros. This is
a good thing that I never got around to doing.

> 1. cleanup-vc-array-access.patch
> 2. remove-console_macrosh.patch
> 3. merge-vt_struct-into-vc_data.patch
> 4. merge-vt_struct-into-vc_data-fix.patch

As for merging the ruby tree. I would suggest we wait until after the 
summer OSL conference. The reason beinging is that alot of rework is going 
into the fbdev/drm layer. I have ask Jon Smirl to help him with the demo 
at the OSL conference on the next generation X server. 

The next generation X server will be based totally on top of OpenGL using 
drm/fbdev. I'm going to be working with him to make sure that it supported 
full multihead support!!!!! We will not have to do anymore X server hacks. 
All the X Server hack on the PCI bus will go away. So we have alot of work 
ahead. I say by next year this time main stream linux will be 
multi-desktop ready. 



-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now.
http://ads.osdn.com/?ad_id=6595&alloc_id=14396&op=click
