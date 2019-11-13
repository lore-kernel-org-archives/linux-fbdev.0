From: =?UTF-8?Q?Noralf_Tr=c3=b8nnes?= <noralf@tronnes.org>
Date: Wed, 13 Nov 2019 15:27:15 +0000
Subject: Re: [PATCH v4 3/3] fbdev: Unexport unlink_framebuffer()
Message-Id: <26c62d04-760e-cecc-3642-d91b083b12e5@tronnes.org>
List-Id: <linux-fbdev.vger.kernel.org>
References: <20191113115233.18483-1-tzimmermann@suse.de>
 <20191113115233.18483-4-tzimmermann@suse.de>
In-Reply-To: <20191113115233.18483-4-tzimmermann@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: Thomas Zimmermann <tzimmermann@suse.de>, airlied@redhat.com, sean@poorly.run, daniel@ffwll.ch, b.zolnierkie@samsung.com, kraxel@redhat.com, sam@ravnborg.org, emil.velikov@collabora.com
Cc: linux-fbdev@vger.kernel.org, dri-devel@lists.freedesktop.org



Den 13.11.2019 12.52, skrev Thomas Zimmermann:
> There are no external callers of unlink_framebuffer() left. Make the
> function an internal interface.
>=20
> Signed-off-by: Thomas Zimmermann <tzimmermann@suse.de>
> ---

Reviewed-by: Noralf Tr=C3=B8nnes <noralf@tronnes.org>
