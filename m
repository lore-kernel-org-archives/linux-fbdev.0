From: Antonino Daplas <adaplas@pol.net>
Subject: Re: Feature Freeze?
Date: 05 Mar 2003 20:46:57 +0800
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Message-ID: <1046868348.1228.60.camel@localhost.localdomain>
References: <Pine.GSO.4.21.0303051055250.23176-100000@vervain.sonytel.be>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from pine.compass.com.ph ([202.70.96.37])
	by sc8-sf-list1.sourceforge.net with smtp (Exim 3.31-VA-mm2 #1 (Debian))
	id 18qYHF-0001Qm-00
	for <linux-fbdev-devel@lists.sourceforge.net>; Wed, 05 Mar 2003 04:45:43 -0800
In-Reply-To: <Pine.GSO.4.21.0303051055250.23176-100000@vervain.sonytel.be>
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
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: Linux Fbdev development list <linux-fbdev-devel@lists.sourceforge.net>

On Wed, 2003-03-05 at 17:57, Geert Uytterhoeven wrote:
> On 5 Mar 2003, Antonino Daplas wrote:
> > I believe it's time to finalize what is needed/not needed for the
> > framebuffer framework:
> 
> > 1. Text mode support?
> 
> Required by at least davem and petr
> 
> > 2. console resizing using fbset (besides stty)?
> 
> Nice, if it's not too much work.

Adding this shouldn't be too hard.

> 
> > 3. support for unloading of fbcon if modular?

So we just make fbcon permanently loaded unconditionally?  The current
code allows 'rmmod fbcon', but it will freeze the system.

> 0. Update all drivers
> 
> Absolutely required

Yes, which is why we need a feature freeze, so we can spend the rest of
the period on driver updating and bug fixing.

Tony



-------------------------------------------------------
This sf.net email is sponsored by:ThinkGeek
Welcome to geek heaven.
http://thinkgeek.com/sf
