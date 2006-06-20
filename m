From: "Antonino A. Daplas" <adaplas@pol.net>
Subject: Re: [PATCH 2.6.17-rc6-mm2] fbdev: tag by
	scantype in sysfs
Date: Tue, 20 Jun 2006 16:42:34 +0800
Message-ID: <4497B4FA.2080602@pol.net>
References: <4497AA7A.5050507@st.com>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1Fsbos-0003E3-5w for linux-fbdev-devel@lists.sourceforge.net;
	Tue, 20 Jun 2006 01:42:46 -0700
Received: from nz-out-0102.google.com ([64.233.162.193])
	by mail.sourceforge.net with esmtp (Exim 4.44) id 1Fsboq-0002oV-Tr
	for linux-fbdev-devel@lists.sourceforge.net;
	Tue, 20 Jun 2006 01:42:46 -0700
Received: by nz-out-0102.google.com with SMTP id m22so1353533nzf
	for <linux-fbdev-devel@lists.sourceforge.net>;
	Tue, 20 Jun 2006 01:42:43 -0700 (PDT)
In-Reply-To: <4497AA7A.5050507@st.com>
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
To: Daniel THOMPSON <daniel.thompson@st.com>
Cc: linux-fbdev-devel@lists.sourceforge.net

Daniel THOMPSON wrote:
> There has been no further comment since this was posted in early May.
> This either means is uncontentious or useless ... I hope the former.
> 

I thought you were still in 'discussion' mode with Geert :-)

Anyway, this should be fine, I'm just a bit worried that it might
break existing user apps that might be used to having modes without
the scan type specified.

Tony
