From: Luca <kronos@people.it>
Subject: Re: [PATCH 2.6.17-rc6-mm2] fbdev: tag by
	scantype in sysfs
Date: Fri, 23 Jun 2006 22:23:34 +0200
Message-ID: <20060623202334.GB11069@dreamland.darkstar.lan>
References: <4497AA7A.5050507@st.com> <4497B4FA.2080602@pol.net>
	<4497C289.5060007@st.com> <4497CE24.7050908@gmail.com>
	<1151049881.12499.18.camel@butch.bri.st.com>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1FtsBc-00048c-PD for linux-fbdev-devel@lists.sourceforge.net;
	Fri, 23 Jun 2006 13:23:29 -0700
Received: from mail-relay-3.tiscali.it ([213.205.33.43])
	by mail.sourceforge.net with esmtp (Exim 4.44) id 1FtsBb-0006Au-5F
	for linux-fbdev-devel@lists.sourceforge.net;
	Fri, 23 Jun 2006 13:23:28 -0700
Content-Disposition: inline
In-Reply-To: <1151049881.12499.18.camel@butch.bri.st.com>
List-Id: <fbdev-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=linux-fbdev-devel>
List-Post: <mailto:linux-fbdev-devel@lists.sourceforge.net>
List-Help: <mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=subscribe>
Sender: linux-fbdev-devel-bounces@lists.sourceforge.net
Errors-To: linux-fbdev-devel-bounces@lists.sourceforge.net
To: daniel.thompson@st.com, linux-fbdev-devel@lists.sourceforge.net
Cc: "Antonino A. Daplas" <adaplas@gmail.com>

Il Fri, Jun 23, 2006 at 09:04:41AM +0100, Daniel THOMPSON ha scritto: 
> > Secondly, that attribute 'modes' violate the 'one file, one value'
> > rule of
> > sysfs (and that includes 'virtual_size', and 'pan').  We need to clean
> > these up.  How about something like this?
> 
> Strictly speaking so does the mode string. This is, in fact, why adding
> information to it has the potential to break existing applications.
> 
> Ideally each mode should itself be a directory containing files like
> hsize, vsize, scantype, vfreq ...
> 
> Given each mode directory would have a unique name we could then use
> that to switch display modes (i.e. write an enumerated name rather than
> a mode string).
> 
> The problem with this approach is I can't think of any way to do the
> work currently performed by store_modes().

I think that configfs is able to deal with this using commitable items.
But having half of the framebuffer configured using sysfs and the other
half using configfs is a bit ugly :|

Luca
-- 
Home: http://kronoz.cjb.net
"Accadono cose che sono come domande. Passa un minuto, oppure anni, e
 poi la vita risponde."

Using Tomcat but need to do more? Need to support web services, security?
Get stuff done quickly with pre-integrated technology to make your job easier
Download IBM WebSphere Application Server v.1.0.1 based on Apache Geronimo
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=120709&bid=263057&dat=121642
