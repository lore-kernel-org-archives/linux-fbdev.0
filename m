From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Date: Thu, 24 Sep 2015 10:56:58 +0000
Subject: Re: [PATCH 4/4] fbdev: Debug knob to register without holding console_lock
Message-Id: <5603D6FA.5090703@ti.com>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="CkuG53cwhtHFsxCsbSp9W5fOp6obNP1Ar"
List-Id: <linux-fbdev.vger.kernel.org>
References: <1440510314-8633-1-git-send-email-daniel.vetter@ffwll.ch>
 <1440510314-8633-4-git-send-email-daniel.vetter@ffwll.ch>
 <CAF6AEGu54g+5Q0ZQXeMd7HLHkGWPw+sdo-FZ4qVS=9nB6nLwtw@mail.gmail.com>
 <55E57ED1.5060109@ti.com>
 <CAF6AEGtV1-tgvA0D-BFZ8NMNyNN7C8-jst5xXBKrQHGFVWCpyA@mail.gmail.com>
In-Reply-To: <CAF6AEGtV1-tgvA0D-BFZ8NMNyNN7C8-jst5xXBKrQHGFVWCpyA@mail.gmail.com>
To: Rob Clark <robdclark@gmail.com>
Cc: Daniel Vetter <daniel.vetter@ffwll.ch>, Intel Graphics Development <intel-gfx@lists.freedesktop.org>, Jean-Christophe Plagniol-Villard <plagnioj@jcrosoft.com>, Linux Fbdev development list <linux-fbdev@vger.kernel.org>, DRI Development <dri-devel@lists.freedesktop.org>

--CkuG53cwhtHFsxCsbSp9W5fOp6obNP1Ar
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable



On 01/09/15 17:34, Rob Clark wrote:

> I hadn't had a chance to look at it further yet..  I think Daniel
> claimed it worked for him, but he was probably on intel-next, where I
> was on drm-next at the time which seemed to be having some unrelated
> i915 issues (when I was trying to debug atomic fb-helper patches).  So
> can't really say that the issue I had was actually related to this
> patch.  I'll try again later this week or next, when hopefully i915 in
> drm-next is in better shape..

Rob, did you have a chance to test this?

 Tomi


--CkuG53cwhtHFsxCsbSp9W5fOp6obNP1Ar
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBCAAGBQJWA9b6AAoJEPo9qoy8lh71bEYQAIEuSpJMYkGW/SmVuRro/hzx
ovDsusbF0kitHE1tJEu9EzGopzkN0Erj7MOTIIu5mdCCEa68pRVLABXGTQkHNAHh
WBomk4qjQ6cRfpU+SevseRkJbdEHwYc299Mbn3P0HgX0UaLtiOxpgHRn3y0C/WO6
gqCspZvnRCVei9NtM+PLawHjfTeK3kA5d3KHTaXhrzhhj4TZ9Ad9x+V7MuZxhQpU
Q5RWcGd5ZZ0ID5T9f3/SknD8N1ym5sHFIAVeCFee7md4ixOQp1yWjZlUub+Jx2sw
s3hpUwAwfswPlngVAW8BrgdeUkyboAljF/CrHbrgWx9PMlRCQxoiFTMFd7VdOE6U
lM3F7xojsoDurZ/3O4Mxo2AOWm5OSFyKeLozSRJ25A1pwGBeOPKx5XQugILfO3Iw
AuOW4uOY9kaxfKDK/d58QuZIfEZZCZURpIfwmacry7zyIPC/RC/t2OYTK0a5+kr7
tV6RyVThKk641aXMbbRjxh4A9oivx8CO7hRxrYD4TI04PBXrDXdO1ZbhiCfS11Y/
B8nxlc00JsaIb8UGap7hgGx1s70WGQz1ATCwfFNcmMRjKfC4fBJgx00BjA1vQ13J
TOIYZCSPUIZfRTf3L1HH6HTpi9vNmkObvN8C2/qYIRT7p7UDPyA4zOm5b+Lbbg/j
Q9AUU9f17aKxNNFkCP5w
=Gu4Z
-----END PGP SIGNATURE-----

--CkuG53cwhtHFsxCsbSp9W5fOp6obNP1Ar--
