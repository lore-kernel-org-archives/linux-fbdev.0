From: Alex Deucher <alexdeucher@gmail.com>
Subject: Re: aty128fb artifacts
Date: Mon, 1 Jun 2009 09:57:09 -0400
Message-ID: <a728f9f90906010657n4c1c3f2cr11073fabbd2b3284@mail.gmail.com>
References: <6f8c04400906010007x160bf846hbd8d8ece0277ea7c@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-bounces@lists.sourceforge.net>
Received: from sfi-mx-3.v28.ch3.sourceforge.com ([172.29.28.123]
	helo=mx.sourceforge.net)
	by 3yr0jf1.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <alexdeucher@gmail.com>) id 1MB88b-0007pZ-4s
	for linux-fbdev-devel@lists.sourceforge.net;
	Mon, 01 Jun 2009 14:05:17 +0000
Received: from mail-fx0-f177.google.com ([209.85.220.177])
	by 3b2kzd1.ch3.sourceforge.com with esmtp (Exim 4.69)
	id 1MB88W-0001g4-4F for linux-fbdev-devel@lists.sourceforge.net;
	Mon, 01 Jun 2009 14:05:17 +0000
Received: by fxm25 with SMTP id 25so7354640fxm.10
	for <linux-fbdev-devel@lists.sourceforge.net>;
	Mon, 01 Jun 2009 07:05:11 -0700 (PDT)
In-Reply-To: <6f8c04400906010007x160bf846hbd8d8ece0277ea7c@mail.gmail.com>
List-Id: <fbdev-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux-fbdev-devel>
List-Post: <mailto:linux-fbdev-devel@lists.sourceforge.net>
List-Help: <mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=subscribe>
Errors-To: linux-fbdev-devel-bounces@lists.sourceforge.net
To: Jonathan Nieder <jrnieder@gmail.com>
Cc: linux-fbdev-devel@lists.sourceforge.net

On Mon, Jun 1, 2009 at 3:07 AM, Jonathan Nieder <jrnieder@gmail.com> wrote:

> I am interested to hear your thoughts. So far, I have found no
> documentation on the Rage M3's internals so I am clueless when faced
> with all these symptoms.

The display engine is very similar the radeon display engine and is
well documented in the xorg r128 and radeon drivers:
http://cgit.freedesktop.org/xorg/driver/xf86-video-r128/
http://cgit.freedesktop.org/xorg/driver/xf86-video-ati/

Alex

------------------------------------------------------------------------------
Register Now for Creativity and Technology (CaT), June 3rd, NYC. CaT 
is a gathering of tech-side developers & brand creativity professionals. Meet
the minds behind Google Creative Lab, Visual Complexity, Processing, & 
iPhoneDevCamp as they present alongside digital heavyweights like Barbarian 
Group, R/GA, & Big Spaceship. http://p.sf.net/sfu/creativitycat-com 
