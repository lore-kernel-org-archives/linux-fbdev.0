From: Walt H <waltabbyh@comcast.net>
Subject: vesafb problem with 1GB Ram and possible fix
Date: Fri, 28 Mar 2003 12:59:55 -0800
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Message-ID: <3E84B7CB.1010604@comcast.net>
References: <3E8329D2.7040909@comcast.net> <20030327190222.GA4060@middle.of.nowhere> <3E837ADD.9080209@comcast.net>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from 12-229-98-127.client.attbi.com ([12.229.98.127] helo=waltsathlon.localhost.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 3.31-VA-mm2 #1 (Debian))
	id 18z0xJ-0001Rj-00
	for <linux-fbdev-devel@lists.sourceforge.net>; Fri, 28 Mar 2003 13:00:05 -0800
Received: from comcast.net (localhost [127.0.0.1])
	by waltsathlon.localhost.net (Postfix) with ESMTP id 8DA31843E22
	for <linux-fbdev-devel@lists.sourceforge.net>; Fri, 28 Mar 2003 12:59:56 -0800 (PST)
In-Reply-To: <3E837ADD.9080209@comcast.net>
Errors-To: linux-fbdev-devel-admin@lists.sourceforge.net
List-Help: <mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:linux-fbdev-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=subscribe>
List-Id: <fbdev-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=linux-fbdev-devel>
Content-Type: text/plain; charset="us-ascii"; format="flowed"
To: linux-fbdev-devel@lists.sourceforge.net

I've got a Chaintech 7KDD dual processor 760MPX MB with 1 GB RAM. I had 
   problem getting vesafb or rivafb to work. I got ioremap errors during 
nitialization, which appear to be because vesafb tries to ioremap the 
entire 128MB framebuffer of my video card. It's a GeForce 4 Ti4600 with 
128MB Ram. Through correspondence on the general linux-kernel mailing 
list, I learned about changing the vmalloc reserved space from 128 to 
256MB, but that didn't work for me as it evidently blows away high-mem IO.

Well, here's what I've done. I've made a change in video/vesafb.c to
change __init vesafb_init to only allocate the amount of memory required 
  for the requested video mode of the framebuffer (I think). So far, it 
appears to work fine. I haven't tried many modes yet, but it's worked 
with what I've thrown at it. Thanks again,

The trivial change I made was changing this:

video_size	= screen_info.lfb_size * 65536;

to this:

video_size	= screen_info.lfb_width * screen_info.lfb_height * video_bpp;


I'm not a kernel hacker, so if I'm overlooking something please let me 
know. I've tested this a fair amount and it appears to be working on my 
end. Please CC me on any replies. Thanks,

-Walt




-------------------------------------------------------
This SF.net email is sponsored by:
The Definitive IT and Networking Event. Be There!
NetWorld+Interop Las Vegas 2003 -- Register today!
http://ads.sourceforge.net/cgi-bin/redirect.pl?keyn0001en
