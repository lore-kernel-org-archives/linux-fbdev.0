From: Stefan Krah <sfk1@bigfoot.com>
Subject: Re: [Solved] (was: Matrox G550, matroxfb: "Signal out of range")
Date: Thu, 30 Jan 2003 17:11:19 +0100
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Message-ID: <20030130161119.GA384@irkutsk.ip503cbb7c.speed.planet.nl>
References: <20030129134227.GA201@irkutsk.ip503cbb7c.speed.planet.nl>
Mime-Version: 1.0
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from ip503cbb7c.speed.planet.nl ([80.60.187.124])
	by sc8-sf-list1.sourceforge.net with smtp (Exim 3.31-VA-mm2 #1 (Debian))
	id 18eHGw-0006zu-00
	for <linux-fbdev-devel@lists.sourceforge.net>; Thu, 30 Jan 2003 08:10:38 -0800
Content-Disposition: inline
In-Reply-To: <20030129134227.GA201@irkutsk.ip503cbb7c.speed.planet.nl>
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
Content-Transfer-Encoding: 7bit
To: linux-fbdev-devel@lists.sourceforge.net

Stefan Krah <sfk1@bigfoot.com> wrote:
[kernel 2.4.20]
> The problem:
> 
> At bootup my monitor displays a warning sign saying:
> 
>        Signal out of range
>        125.8 kHz    173Hz
> 
> The warning sign is distorted (stretched vertically) and disappears
> after 4 seconds. From that moment on the framebuffer works normally
> and with the very frequencies I specified in /etc/lilo.conf.

I have just tried out 2.4.21-pre4 and the problem disappeared.


Stefan Krah


-------------------------------------------------------
This SF.NET email is sponsored by:
SourceForge Enterprise Edition + IBM + LinuxWorld = Something 2 See!
http://www.vasoftware.com
