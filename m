From: Eric Anholt <eric@anholt.net>
Date: Tue, 19 Apr 2016 20:23:53 +0000
Subject: Re: [PATCH] simplefb: Disable at runtime when a native driver (vc4) is present.
Message-Id: <87a8kps5ye.fsf@eliezer.anholt.net>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="=-=-="
List-Id: <linux-fbdev.vger.kernel.org>
References: <1461093565-18631-1-git-send-email-eric@anholt.net>
In-Reply-To: <1461093565-18631-1-git-send-email-eric@anholt.net>
To: linux-fbdev@vger.kernel.org

--=-=-=
Content-Type: text/plain

Hans de Goede <hdegoede@redhat.com> writes:

> Hi Eric,
>
> On 04/19/2016 09:19 PM, Eric Anholt wrote:
>> With simplefb and vc4 both enabled, simplefb would probe first and be
>> fb0, displaying for a moment before vc4 probed fb1 and reconfigured
>> the graphics hardware so that only its fbdev worked.
>
> The way this is supposed to work (theoretically you're the first
> one to hit this on ARM) is that you call remove_conflicting_framebuffers()
> from the probe of your driver.
>
> simplefb can only be built-in and uses fs_initcall() to register itself,
> so that it becomes available early on, so it should always be probed
> before the vc4 driver.
>
> When we discussed how all of this should fit together (again theoretically)
> at ELCE 2014, we decided to follow what the x86 kms driver do here, the
> idea was that u-boot would set up a console (so that the user can interact
> with u-boot / see error messages without hooking up a serial console) and
> then simplefb would pick up the u-boot console asap, so that the kernel
> can show error msg. This is esp. important for the Debian / Fedora ARM
> images where things like the vc4 driver will be a module and we want
> the user to see errors from the initrd if things go wrong before loading
> e.g. the vc4 module.
>
> So the boot sequence would be:
>
> 1) u-boot configures a framebuffer, shows msgs there
> 2) kernel brings on builtin simplefb early, shows msgs that way
> 3) vc4 driver loads calls remove_conflicting_framebuffers which should
>     disable/remove the simplefb framebuffer
> 4) vc4 driver register its own framebuffer, kernel msgs get displayed there
>
> I hope this makes sense, let me know if you've any questions.

I hadn't seen this in the other ARM drivers, so I hadn't found that
solution.  Looks like it works fine, the only funny part being that I
have to use 0 to ~0 for my aperture because it's a UMA system.

--=-=-=
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBCgAGBQJXFpPZAAoJELXWKTbR/J7oBxUP/3c6UMcxd56lkFfBugmJTtFq
mVZ0vn1HOhwp+vYODJKix2cSwBjbSWTB44/1Ci6VX3nQ+xecnUPL6KggYR4VUt4a
Pr4j2b/Lq8ggzWb0xilkcmTggKUVcLYj7BZxK0+loZyVZ9a4cz7oWpcrUcKoHcTW
sGNlUed31RqZWe6JYzbLZN3ap27VEyXcpV8OSa1OIZTb1acx7HUQGMVSKpTe7y06
aUwjKhdz2WOYnulGlLTrSPBq7z1K6b+UlLUP68VIvWxECZfbcvHkJo1LjoW5ENgS
OwDXHAb7DPuT9S1sfzWvjFwdUhelUvrLGCGsvzUsMT+CPadaAiHYNNgyZZAVAAJ6
/WMXgVlADUhpkjuZuteH0PmuupsfzaFi/2JO/vp4y120YGNX60ykQ2Wz5zJloI1C
NR1/aD35GePCs6OWWYq8pP5yteX9P+82Mh7R5O4lc8JmweNhYhBj5QPmi7rXX0UW
eMGWEU4PKi+kfNHm35FBYmNqPDyksf6JCpG6Hqna6u0wdVuttY6gV2LAJIgR1fiG
8BstDTzlgfgNXl9NLQOJgipBN/9N7vuwMl9qtLRD6Ccd3sAn3luyIG6nZ0SFRN2Y
ORPPPW37E8+P8YadponccCO3wslR6hVUxHDWEgNX9U9tjao8S2MXgbzpggQp9y4q
E1FfA91M5+MOszIeDTF1
=LrIY
-----END PGP SIGNATURE-----
--=-=-=--
