From: Antonino Daplas <adaplas@pol.net>
Subject: Re: Frame buffer Reading fails!!
Date: 04 Jan 2003 19:06:37 +0800
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Message-ID: <1041678353.957.8.camel@localhost.localdomain>
References: <00df01c2b33f$a1354690$bd00000a@abhilash>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from willow.compass.com.ph ([202.70.96.38])
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 3.31-VA-mm2 #1 (Debian))
	id 18UmKl-0002Ul-00
	for <linux-fbdev-devel@lists.sourceforge.net>; Sat, 04 Jan 2003 03:19:20 -0800
Received: from AP-202-70-105-31.compass.com.ph (AP-202-70-105-31.compass.com.ph [202.70.105.31])
	by willow.compass.com.ph (8.9.3/8.9.3) with ESMTP id TAA46606
	for <linux-fbdev-devel@lists.sourceforge.net>; Sat, 4 Jan 2003 19:19:15 +0800 (PHT)
	(envelope-from adaplas@pol.net)
In-Reply-To: <00df01c2b33f$a1354690$bd00000a@abhilash>
Errors-To: linux-fbdev-devel-admin@lists.sourceforge.net
List-Help: <mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:linux-fbdev-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=subscribe>
List-Id: <fbdev-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=linux-fbdev-devel>
Content-Type: text/plain; charset="us-ascii"
To: Linux Fbdev development list <linux-fbdev-devel@lists.sourceforge.net>

On Fri, 2003-01-03 at 23:48, Abhilash wrote:
> Hello,
> 
> As u suggested I tried following code in RedHat7.1.
> But it shows
> 
>  "The framebuffer device was opened successfully."
>  "Error reading fixed information."
> 
> What could be the problem?
> I am new to this.
> 

Try doing it again as root.  /dev/fbX is most probably owned by root (as
it should be).

If it still doesn't work, do a  

cat /dev/urandom > /dev/fb0 

to check if /dev/fb0 is valid.  BTW, what fb driver are you using?

Tony





-------------------------------------------------------
This sf.net email is sponsored by:ThinkGeek
Welcome to geek heaven.
http://thinkgeek.com/sf
