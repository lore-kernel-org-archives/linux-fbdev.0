From: =?UTF-8?Q?Noralf_Tr=c3=b8nnes?= <noralf@tronnes.org>
Date: Wed, 13 Nov 2019 15:26:57 +0000
Subject: Re: [PATCH v4 2/3] drm/fb-helper: Remove drm_fb_helper_unlink_fbi()
Message-Id: <9a532541-9c5b-988c-b043-c7c3365aa49d@tronnes.org>
List-Id: <linux-fbdev.vger.kernel.org>
References: <20191113115233.18483-1-tzimmermann@suse.de>
 <20191113115233.18483-3-tzimmermann@suse.de>
In-Reply-To: <20191113115233.18483-3-tzimmermann@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: Thomas Zimmermann <tzimmermann@suse.de>, airlied@redhat.com, sean@poorly.run, daniel@ffwll.ch, b.zolnierkie@samsung.com, kraxel@redhat.com, sam@ravnborg.org, emil.velikov@collabora.com
Cc: linux-fbdev@vger.kernel.org, dri-devel@lists.freedesktop.org



Den 13.11.2019 12.52, skrev Thomas Zimmermann:
> There are no callers of drm_fb_helper_unlink_fbi() left. Remove the
> function.
>=20
> Signed-off-by: Thomas Zimmermann <tzimmermann@suse.de>
> ---

Reviewed-by: Noralf Tr=C3=B8nnes <noralf@tronnes.org>
