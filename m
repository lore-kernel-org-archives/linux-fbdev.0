From: "Michal Piotrowski" <michal.k.k.piotrowski@gmail.com>
Subject: Re: [PATCH 3/8] nvidiafb: Add proper support
	for Geforce 7600 chipset
Date: Thu, 31 May 2007 18:16:10 +0200
Message-ID: <6bffcb0e0705310916o35cfe6ddm9c9a91199ebd79b0@mail.gmail.com>
References: <465EC6BF.6070008@gmail.com>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-fbdev-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1HtnJv-0005WC-IS for linux-fbdev-devel@lists.sourceforge.net;
	Thu, 31 May 2007 09:16:16 -0700
Received: from wa-out-1112.google.com ([209.85.146.182])
	by mail.sourceforge.net with esmtp (Exim 4.44) id 1HtnJt-00042Y-6Z
	for linux-fbdev-devel@lists.sourceforge.net;
	Thu, 31 May 2007 09:16:15 -0700
Received: by wa-out-1112.google.com with SMTP id v33so519164wah
	for <linux-fbdev-devel@lists.sourceforge.net>;
	Thu, 31 May 2007 09:16:12 -0700 (PDT)
In-Reply-To: <465EC6BF.6070008@gmail.com>
Content-Disposition: inline
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
Content-Type: text/plain; charset="iso-8859-1"
To: "Antonino A. Daplas" <adaplas@gmail.com>
Cc: Andrew Morton <akpm@osdl.org>, Linux Fbdev development list <linux-fbdev-devel@lists.sourceforge.net>, Jurriaan <thunder7@xs4all.nl>

Hi Antonino,

On 31/05/07, Antonino A. Daplas <adaplas@gmail.com> wrote:
> Add proper support for the Geforce 7600 (device id 0x039x).  This also sy=
nc's
> nvidiafb with the latest Xorg nv driver.
>
> Signed-off-by: Antonino Daplas <adaplas@gmail.com>
> ---
> Michal,
>
> Can you test this patch? It might directly impact your 7300.
>

It works for me without any problems.

Regards,
Michal

-- =

"Najbardziej brakowa=B3o mi twojego milczenia."
-- Andrzej Sapkowski "Co=B6 wi=EAcej"
-------------------------------------------------------------------------
This SF.net email is sponsored by DB2 Express
Download DB2 Express C - the FREE version of DB2 express and take
control of your XML. No limits. Just data. Click to get it now.
http://sourceforge.net/powerbar/db2/
