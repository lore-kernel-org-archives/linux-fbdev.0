From: Jim Hague <jim.hague@acm.org>
Subject: Re: [PATCH 4/4] pm2fb: fix big-endian (Sparc) support
Date: Tue, 07 Dec 2004 13:35:51 -0000 (GMT)
Message-ID: <XFMail.20041207133551.jim.hague@acm.org>
References: <20041207115034.4b16ad01@hagrid.bear-cave.org.uk>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.12] helo=sc8-sf-mx2.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1CbfVd-0002zf-In
	for linux-fbdev-devel@lists.sourceforge.net; Tue, 07 Dec 2004 05:36:05 -0800
Received: from cpc1-oxfd2-6-0-cust43.oxfd.cable.ntl.com ([81.103.191.43] helo=fluffy.bear-cave.org.uk)
	by sc8-sf-mx2.sourceforge.net with esmtp (TLSv1:DES-CBC3-SHA:168)
	(Exim 4.41)
	id 1CbfVc-0008Uo-67
	for linux-fbdev-devel@lists.sourceforge.net; Tue, 07 Dec 2004 05:36:05 -0800
In-Reply-To: <20041207115034.4b16ad01@hagrid.bear-cave.org.uk>
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Errors-To: linux-fbdev-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Id: <fbdev-devel.lists.sourceforge.net>
List-Post: <mailto:linux-fbdev-devel@lists.sourceforge.net>
List-Help: <mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=linux-fbdev-devel>
Content-Type: text/plain; charset="us-ascii"
To: linux-fbdev-devel@lists.sourceforge.net, Antonino Daplas <adaplas@pol.net>, Andrew Morton <akpm@osdl.org>
Cc: Ron Murray <murrayr@dor.state.ma.us>

On 07-Dec-2004 Jim Hague wrote:
> - Big-endian fixes. The driver is now known to work on Sparc.

That's a crap patch description. Sorry. Let's try again:

A collection of changes that taken together makes the driver work correctly on
big-endian systems, specifically Sparc.

- Remove old PM2FB_BE_APERTURE define and use __BIG_ENDIAN
  throughout. PM2FB_BE_APERTURE wasn't defined on Sparc; this
  was incorrect.
- Replace colour mode magic numbers with suitable constants,
  and tidy colour mode handling. Use BGR not RGB at 24bit on
  big-endian.
- Replace aperture magic numbers with constants. Rearrange code to
  emphasise second aperture is not used. Add short explanations
  of aperture settings for big endian.
- Update comments to note that the driver now works on Sparc.
- Revisit 32bit depth colour offsets and ensure transp is set.



-- 
Jim Hague - jim.hague@acm.org          Never trust a computer you can't lift.


-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now. 
http://productguide.itmanagersjournal.com/
