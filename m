From: Antonino Daplas <adaplas@pol.net>
Subject: Re: RFC: Optimizing putcs()
Date: 07 Aug 2002 08:17:44 +0800
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Message-ID: <1028679284.554.37.camel@daplas>
References: <Pine.GSO.4.21.0208062204390.5852-100000@vervain.sonytel.be>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from [203.167.79.9] (helo=willow.compass.com.ph)
	by usw-sf-list1.sourceforge.net with esmtp (Exim 3.31-VA-mm2 #1 (Debian))
	id 17cES6-0001uO-00
	for <linux-fbdev-devel@lists.sourceforge.net>; Tue, 06 Aug 2002 17:13:26 -0700
Received: from AP-203.167.30.66.sysads.com (cwd66.compass.com.ph [203.167.30.66])
	by willow.compass.com.ph (8.9.3/8.9.3) with ESMTP id IAA97947
	for <linux-fbdev-devel@lists.sourceforge.net>; Wed, 7 Aug 2002 08:13:22 +0800 (PHT)
	(envelope-from adaplas@pol.net)
In-Reply-To: <Pine.GSO.4.21.0208062204390.5852-100000@vervain.sonytel.be>
Errors-To: linux-fbdev-devel-admin@lists.sourceforge.net
List-Help: <mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:linux-fbdev-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=subscribe>
List-Id: <fbdev-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://www.geocrawler.com/redir-sf.php3?list=linux-fbdev-devel>
Content-Type: text/plain; charset="us-ascii"
To: fbdev <linux-fbdev-devel@lists.sourceforge.net>

On Wed, 2002-08-07 at 04:08, Geert Uytterhoeven wrote:

> 
> Just for reference, did you run this benchmark on 2.4.x as well?
> 
> Gr{oetje,eeting}s,
> 
Sort of. The functions in fbcon-cfb*.c are already very fast, because
fbcon and character drawing are tightly integrated together, and
fbcon_cfb8_putcs() is very, very efficient, processing 4 bits per
iteration, instead of 1.  I'm getting numbers like this:

real    0m2.098s
user    0m0.000s
sys     0m2.070s

which was faster(!) than my hardware implementation of putcs, and 5x
faster than 2.5.  Since I'm using an i810 with Video in System RAM,
direct framebuffer access does not carry much overhead.  I just have to
beat fbcon-cfb8, so I thought of placing text data in offscreen graphics
memory to take full advantage of hardware blitting.

At high bit depths (32 bpp), 2.5 with an offscreen buffer is as fast as
2.4.

Tony    




-------------------------------------------------------
This sf.net email is sponsored by:ThinkGeek
Welcome to geek heaven.
http://thinkgeek.com/sf
