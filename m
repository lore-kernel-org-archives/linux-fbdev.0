From: Daniel THOMPSON <daniel.thompson@st.com>
Subject: Re: [PATCH 2.6.17-rc6-mm2] fbdev: tag by
	scantype in sysfs
Date: Tue, 20 Jun 2006 10:40:25 +0100
Message-ID: <4497C289.5060007@st.com>
References: <4497AA7A.5050507@st.com> <4497B4FA.2080602@pol.net>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1Fsckp-0008Vl-Eb for linux-fbdev-devel@lists.sourceforge.net;
	Tue, 20 Jun 2006 02:42:39 -0700
Received: from fra-del-03.spheriq.net ([195.46.51.99])
	by mail.sourceforge.net with esmtps (TLSv1:DES-CBC3-SHA:168)
	(Exim 4.44) id 1Fsckm-00019E-Q6
	for linux-fbdev-devel@lists.sourceforge.net;
	Tue, 20 Jun 2006 02:42:39 -0700
Received: from fra-out-03.spheriq.net (fra-out-03.spheriq.net [195.46.51.131])
	by fra-del-03.spheriq.net with ESMTP id k5K9gUMq026206
	for <linux-fbdev-devel@lists.sourceforge.net>;
	Tue, 20 Jun 2006 09:42:30 GMT
Received: from fra-cus-01.spheriq.net (fra-cus-01.spheriq.net [195.46.51.37])
	by fra-out-03.spheriq.net with ESMTP id k5K9gUZN031067
	for <linux-fbdev-devel@lists.sourceforge.net>;
	Tue, 20 Jun 2006 09:42:30 GMT
In-Reply-To: <4497B4FA.2080602@pol.net>
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
To: "Antonino A. Daplas" <adaplas@pol.net>
Cc: linux-fbdev-devel@lists.sourceforge.net

Antonino A. Daplas wrote:
> Daniel THOMPSON wrote:
>> There has been no further comment since this was posted in early May.
>> This either means is uncontentious or useless ... I hope the former.
>>
> 
> I thought you were still in 'discussion' mode with Geert :-)

I was, but there was no further discussion so I brought it back to you.

> Anyway, this should be fine, I'm just a bit worried that it might
> break existing user apps that might be used to having modes without
> the scan type specified.

I shared this worry which is why my original patch only tagged the,
comparatively rare, interlaced modes. However the current approach (no
optional fields) is slightly cleaner and I took the view that since
no-one on fbdev-devel seems to object ...

-- 
Daniel Thompson (STMicroelectronics) <daniel.thompson@st.com>
1000 Aztec West, Almondsbury, Bristol, BS32 4SQ. 01454 462659

If a car is a horseless carriage then is a motorcycle a horseless horse?
