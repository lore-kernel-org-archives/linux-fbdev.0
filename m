From: Michel =?ISO-8859-1?Q?D=E4nzer?= <michel@daenzer.net>
Subject: Re: [PATCH] Remove voodoo code from i2c
Date: Sat, 06 Mar 2004 01:12:03 +0100
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Message-ID: <1078531922.2751.69.camel@thor.asgaard.local>
References: <20040305215210.GA23402@dreamland.darkstar.lan>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11] helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1AzPee-0000Lt-IV
	for linux-fbdev-devel@lists.sourceforge.net; Fri, 05 Mar 2004 16:27:00 -0800
Received: from netline-mail1.netline.ch ([195.141.226.27])
	by sc8-sf-mx1.sourceforge.net with esmtp (Exim 4.30)
	id 1AzPQF-000327-UM
	for linux-fbdev-devel@lists.sourceforge.net; Fri, 05 Mar 2004 16:12:08 -0800
In-Reply-To: <20040305215210.GA23402@dreamland.darkstar.lan>
Errors-To: linux-fbdev-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Id: <fbdev-devel.lists.sourceforge.net>
List-Post: <mailto:linux-fbdev-devel@lists.sourceforge.net>
List-Help: <mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=linux-fbdev-devel>
Content-Type: text/plain; charset="iso-8859-1"
To: kronos@kronoz.cjb.net
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>, linux-fbdev-devel@lists.sourceforge.net

On Fri, 2004-03-05 at 22:52, Kronos wrote:
> Hi,
> radeon_probe_i2c_connector contains very strange code that just send
> empty start-stop sequencies on the I2C bus. I copied the code from
> XFree86, but speaking with I2C gurus the general feeling is that this
> code can go away without any harm. I tested it on 3 different setup (all
> x86...) and it works well. I don't have any "old" monitor around to
> fiddle with though.

Have you asked Hui Yu, assuming the code originates from him? He might
be able to explain what it's all about. There are many kinds of Radeon
cards out there, some very weird...


--=20
Earthling Michel D=C3=A4nzer      |     Debian (powerpc), X and DRI develop=
er
Libre software enthusiast    |   http://svcs.affero.net/rm.php?r=3Ddaenzer



-------------------------------------------------------
This SF.Net email is sponsored by: IBM Linux Tutorials
Free Linux tutorial presented by Daniel Robbins, President and CEO of
GenToo technologies. Learn everything from fundamentals to system
administration.http://ads.osdn.com/?ad_id=3D1470&alloc_id=3D3638&op=3Dclick
