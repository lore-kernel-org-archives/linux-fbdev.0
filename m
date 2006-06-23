From: Daniel THOMPSON <daniel.thompson@st.com>
Subject: Re: [PATCH 2.6.17-rc6-mm2] fbdev:
	tag	by	scantype in sysfs
Date: Fri, 23 Jun 2006 09:04:41 +0100
Message-ID: <1151049881.12499.18.camel@butch.bri.st.com>
References: <4497AA7A.5050507@st.com> <4497B4FA.2080602@pol.net>
	<4497C289.5060007@st.com>  <4497CE24.7050908@gmail.com>
Reply-To: daniel.thompson@st.com,
	linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1FtggN-0004vN-Jn for linux-fbdev-devel@lists.sourceforge.net;
	Fri, 23 Jun 2006 01:06:27 -0700
Received: from lon-del-03.spheriq.net ([195.46.50.99])
	by mail.sourceforge.net with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.44) id 1FtggM-0006y7-Ok
	for linux-fbdev-devel@lists.sourceforge.net;
	Fri, 23 Jun 2006 01:06:27 -0700
Received: from lon-out-01.spheriq.net ([195.46.50.129])
	by lon-del-03.spheriq.net with ESMTP id k5N86LQX003587
	for <linux-fbdev-devel@lists.sourceforge.net>;
	Fri, 23 Jun 2006 08:06:21 GMT
Received: from lon-cus-02.spheriq.net (lon-cus-02.spheriq.net [195.46.50.38])
	by lon-out-01.spheriq.net with ESMTP id k5N86JU0027327
	for <linux-fbdev-devel@lists.sourceforge.net>;
	Fri, 23 Jun 2006 08:06:20 GMT
In-Reply-To: <4497CE24.7050908@gmail.com>
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
To: "Antonino A. Daplas" <adaplas@gmail.com>
Cc: linux-fbdev-devel@lists.sourceforge.net

On Tue, 2006-06-20 at 18:29 +0800, Antonino A. Daplas wrote:
> > I shared this worry which is why my original patch only tagged the,
> > comparatively rare, interlaced modes. However the current approach
> (no
> > optional fields) is slightly cleaner and I took the view that since
> > no-one on fbdev-devel seems to object ...
> > 
>         
> Okay.  But if we are going to break this, let's break it with
> finality.
> Does anyone believe that the above format is final? How about
> including
> sync signals too?
>         
> #define FB_SYNC_HOR_HIGH_ACT    1  /* horizontal sync high active  */
> #define FB_SYNC_VERT_HIGH_ACT   2  /* vertical sync high active    */
> #define FB_SYNC_EXT             4  /* external sync                */
> #define FB_SYNC_COMP_HIGH_ACT   8  /* composite sync high active   */
> #define FB_SYNC_BROADCAST       16 /* broadcast video timings      */

Any suggestions about how these should be added to the mode string?

> Secondly, that attribute 'modes' violate the 'one file, one value'
> rule of
> sysfs (and that includes 'virtual_size', and 'pan').  We need to clean
> these up.  How about something like this?

Strictly speaking so does the mode string. This is, in fact, why adding
information to it has the potential to break existing applications.

Ideally each mode should itself be a directory containing files like
hsize, vsize, scantype, vfreq ...

Given each mode directory would have a unique name we could then use
that to switch display modes (i.e. write an enumerated name rather than
a mode string).

The problem with this approach is I can't think of any way to do the
work currently performed by store_modes(). I would however like to know
if anyone actually uses this?

>  /sys/class/graphics---fb0
>                     :
>                     --fb1
>                     :
>                     --fbn
>                     :
>                     --mode0---640x480@60
>                     :       :
>                     :       --1024x768@60
>                     :  
>                     --mode1

So the directory mode0 contains all the modes that fb0 is capable of
displaying? Can't that go inside fb0?

Presumably fb0's existing mode file is replaced with a soft link to the
currently selected mode and a new file is introduced to change modes?

-- 
Daniel Thompson (STMicroelectronics) <daniel.thompson@st.com>
1000 Aztec West, Almondsbury, Bristol, BS32 4SQ. 01454 462659

If a car is a horseless carriage then is a motorcycle a horseless horse?


Using Tomcat but need to do more? Need to support web services, security?
Get stuff done quickly with pre-integrated technology to make your job easier
Download IBM WebSphere Application Server v.1.0.1 based on Apache Geronimo
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=120709&bid=263057&dat=121642
