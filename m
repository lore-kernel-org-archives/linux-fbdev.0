From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: Re: [PATCH] New radeonfb fork
Date: 11 Apr 2003 14:57:10 +0200
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Message-ID: <1050065830.559.25.camel@zion.wanadoo.fr>
References: <56639.80.180.244.42.1049891938.squirrel@squirrel.autistici.org>
	 <1050048156.573.14.camel@zion.wanadoo.fr>  <3E96B979.8030007@autistici.org>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from griffon.mipsys.com ([217.167.51.129] helo=zion.wanadoo.fr)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 3.31-VA-mm2 #1 (Debian))
	id 193y60-0003x9-00
	for <linux-fbdev-devel@lists.sourceforge.net>; Fri, 11 Apr 2003 05:57:33 -0700
In-Reply-To: <3E96B979.8030007@autistici.org>
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
To: paride <torn@autistici.org>
Cc: Linux Fbdev development list <linux-fbdev-devel@lists.sourceforge.net>

On Fri, 2003-04-11 at 14:47, paride wrote:
> Benjamin Herrenschmidt wrote:
> > Looks like the PLL isn't locking properly. The latest driver I'll
> > release (today hopefully) includes a workaround that _might_ help
> 
> I hope so, fixing this issue will make many toshiba and hp users very 
> happy. There are two more thing I think it's better to tell you:
> 
> 1) This happened also with the standard radeonfb. When the driver is 
> loaded, the whole screen image is moded up of about 3 or 4 mm. So the 
> upper part of the screen is cut, and at the bottom there is a black 
> strip. "fbset -vsync high" fixes this perfectly, so this isn't a real 
> problem, maybe is just a characteristic of my hardware, telling you 
> shouldn't hurt.

Just to make sure I understood you, this also happens with my
driver or not ? It's possible that your monitor EDID information
as provided by the BIOS is slightly incorrect, I'll look if there
is no parsing error on my side. Can you send me a dmesg output ?

> 2) when switching from x to console, happens that when the text scrolls 
> outside the screen, it reappears in the bottom part of the screen, very 
> bigger, and everything gets messed up. I don't know if this could be 
> related to the flicker problem, but it never happened with the old 
> radeonfb. Playing a bit with fbset solves the problem. I didn't 
> understand exactly what causes this, I'm investigating.

Isn't fixed by my latest version (URL below) ? 
http://www.penguinppc.org/~benh/radeonfb-041103-2.4.20.diff
http://www.penguinppc.org/~benh/radeonfb-041103-2.4.21-pre7.diff


Ben.



-------------------------------------------------------
This SF.net email is sponsored by: Etnus, makers of TotalView, The debugger 
for complex code. Debugging C/C++ programs can leave you feeling lost and 
disoriented. TotalView can help you find your way. Available on major UNIX 
and Linux platforms. Try it free. www.etnus.com
