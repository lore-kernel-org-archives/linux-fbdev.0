From: Krzysztof Helt <krzysztof.h1@poczta.fm>
Subject: Re: [Bugme-new] [Bug 13285] New: INTELFB:
 Colors display incorrectly
Date: Thu, 4 Jun 2009 22:58:43 +0200
Message-ID: <20090604225843.93bd964f.krzysztof.h1@poczta.fm>
References: <bug-13285-10286@http.bugzilla.kernel.org/>
	<20090512151934.d7e6c54e.akpm@linux-foundation.org>
	<20090517081743.92002707.krzysztof.h1@poczta.fm>
	<20090516231932.2e02647b.akpm@linux-foundation.org>
	<20090517123032.2b8bad00.krzysztof.h1@poczta.fm>
	<a5d587fb0905170807j4cf60ce7ucf675cc6161e7850@mail.gmail.com>
	<20090530135833.6a2c1bb2.krzysztof.h1@poczta.fm>
	<20090602131855.1d69f442.akpm@linux-foundation.org>
	<a5d587fb0906030227j634398c8k369492e1755f2938@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-bounces@lists.sourceforge.net>
In-Reply-To: <a5d587fb0906030227j634398c8k369492e1755f2938@mail.gmail.com>
List-Id: <fbdev-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux-fbdev-devel>
List-Post: <mailto:linux-fbdev-devel@lists.sourceforge.net>
List-Help: <mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=subscribe>
Errors-To: linux-fbdev-devel-bounces@lists.sourceforge.net
To: Michal Suchanek <hramrach@centrum.cz>
Cc: Andrew Morton <akpm@linux-foundation.org>, samanddeanus@yahoo.com, linux-fbdev-devel@lists.sourceforge.net, dri-devel@lists.sourceforge.net, bugzilla-daemon@bugzilla.kernel.org

On Wed, 3 Jun 2009 11:27:17 +0200
Michal Suchanek <hramrach@centrum.cz> wrote:

> Unfortunately I did not get to testing the patch yet.
> 
> According to the description it is supposed to resolve some confusion
> over what pipe is enabled or not.
> 
> X server reports the pipes connected as follows:
> (II) intel(0):   Pipe A is on
> (II) intel(0):   Display plane A is now enabled and connected to pipe A.
> (II) intel(0):   Pipe B is off
> (II) intel(0):   Display plane B is now disabled and connected to pipe A.
> (II) intel(0):   Output VGA is connected to pipe none
> (II) intel(0):   Output TMDS-1 is connected to pipe A
> (II) intel(0):   Output TV is connected to pipe none
> 
> However, I also get this warning before the outputs are listed:
> (WW) intel(0): Couldn't detect panel mode.  Disabling panel
> 
> Is this a configuration that would likely be affected by the issue
> fixed here or do I have a different problem?
> 

Frankly speaking, I don't know. Please describe your problem.

The panel mode I suppose is LVDS (LCD panel directly connected
to the chip) which is possible only in laptops and tablets or other
computers where the LCD panel is integrated with the main unit
(e.g. "desk-lamp" like Apple computers). All other computers which you
connect the display by external cable (DVI/HDMI or VGA) does not
work in the "panel mode".

Kind regards,
Krzysztof


----------------------------------------------------------------------
Sprawdz wiadomosci z Twojego regionu!
Kliknij >>> http://link.interia.pl/f21ba


------------------------------------------------------------------------------
OpenSolaris 2009.06 is a cutting edge operating system for enterprises 
looking to deploy the next generation of Solaris that includes the latest 
innovations from Sun and the OpenSource community. Download a copy and 
enjoy capabilities such as Networking, Storage and Virtualization. 
Go to: http://p.sf.net/sfu/opensolaris-get
