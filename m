From: Austin S Hemmelgarn <ahferroin7@gmail.com>
Date: Thu, 24 Sep 2015 16:17:04 +0000
Subject: Re: No more new fbdev drivers, please
Message-Id: <56042200.5070006@gmail.com>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="------------ms020307070306080802090908"
List-Id: <linux-fbdev.vger.kernel.org>
References: <5603EC15.9090605@ti.com>
 <20150924144621.40e26f0a@free-electrons.com> <560414EB.508@gmail.com>
 <20150924155912.GW3383@phenom.ffwll.local>
In-Reply-To: <20150924155912.GW3383@phenom.ffwll.local>
To: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>, Tomi Valkeinen <tomi.valkeinen@ti.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, linux-fbdev <linux-fbdev@vger.kernel.org>, DRI Development <dri-devel@lists.freedesktop.org>, Sudip Mukherjee <sudipm.mukherjee@gmail.com>, Teddy Wang <teddy.wang@siliconmotion.com>, =?UTF-8?Q?Noralf_Tr=c3=b8nnes?= <noralf@tronnes.org>, Laurent Pinchart <laurent.pinchart@ideasonboard.com>, Dave Airlie <airlied@redhat.com>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Arnaud Patard <apatard@mandriva.com>

This is a cryptographically signed message in MIME format.

--------------ms020307070306080802090908
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: quoted-printable

On 2015-09-24 11:59, Daniel Vetter wrote:
> On Thu, Sep 24, 2015 at 11:21:15AM -0400, Austin S Hemmelgarn wrote:
>> On 2015-09-24 08:46, Thomas Petazzoni wrote:
>>> Hello,
>>>
>>> On Thu, 24 Sep 2015 15:27:01 +0300, Tomi Valkeinen wrote:
>>>
>>>> fbdev is (more or less) maintained, but it's a deprecated framework.=
 All
>>>> new Linux display drivers should be done on DRM.
>>>>
>>>> So let's not add any more new fbdev drivers.
>>>>
>>>> I will continue to maintain the current fbdev drivers, and I don't m=
ind
>>>> adding some new features to those current drivers, as long as the am=
ount
>>>> of code required to add the features stays sensible.
>>>>
>>>> I see we have three fbdev drivers in staging: xgifb, fbtft and sm750=
fb,
>>>> and the question is what to do with those.
>>>>
>>>> xgifb was added in 2010, and is still in staging.
>>>>
>>>> fbtft looks like maybe some kind of framework on top of fbdev, with
>>>> fbtft specific subdrivers... I didn't look at it in detail, but my g=
ut
>>>> says "never".
>>>
>>> fbtft mainly drives some very simple I2C-based or SPI-based displays,=

>>> and DRM is I believe overkill for such displays. Last time I talked
>>> with Laurent Pinchart about such drivers, I believe he said that such=

>>> simple drivers could probably continue to use the fbdev subsystem.
>> I have to agree, using DRM _really_ doesn't make sense for these, the
>> devices in question are (AFAIK) simple I2C or SPI connected frame-buff=
er
>> chips that are hooked up to equally simple TFT displays.  There's no 3=
d
>> acceleration at all from what I can tell, there's _very_ limited 2d
>> acceleration, and most of the stuff that the DRM framework provides
>> call-backs for would have to be done on the CPU anyway.  On top of tha=
t,
>> it's targeted at small embedded systems with limited memory, and the D=
RM
>> framework is by no-means lightweight (TBH, fbdev isn't really either, =
but
>> it's much more light weight than DRM).
>
> See my other mail, but you can write very simple drm drivers. And if
> there's really a bloat problem for small systems we can add Kconfig kno=
bs
> to throw out everything not needed for simple drivers. The only problem=

> really is that everyone with such simple drivers doesn't even consider =
drm
> "because I don't have a desktop gpu" which is just silly - drm has beco=
me
> rather flexible. And that's essentially why writing simple drm drivers
> still has a bit too much boilerplate, since no one yet bothered to add =
a
> bit of helper support needed.
>
Rather ironically, I got your other mail right after I sent this one.  I =

hadn't realized most of the points you made there (it's been a long time =

since I looked at any drm related code (largely because I've had=20
absolutely 0 issues on my systems with it, which is a good thing :))).=20
I do think being able to compile out some of the drm stuff that isn't=20
used on a given system would be nice, and some good helper functions to=20
simplify writing basic drivers would be absolutely wonderful.

As far as not considering it 'because I don't have a desktop GPU' goes,=20
I agree, that is silly, although for some people it may be 'because my=20
chip doesn't do any "rendering"', which brings up the rather complicated =

discussion of what constitutes a GPU and what 'rendering' means.



--------------ms020307070306080802090908
Content-Type: application/pkcs7-signature; name="smime.p7s"
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="smime.p7s"
Content-Description: S/MIME Cryptographic Signature

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
cnQub3JnMSIwIAYDVQQDExlDQSBDZXJ0IFNpZ25pbmcgQXV0aG9yaXR5MSEwHwYJKoZIhvcN
AQkBFhJzdXBwb3J0QGNhY2VydC5vcmcCAxEt+DANBglghkgBZQMEAgMFAKCCAiEwGAYJKoZI
hvcNAQkDMQsGCSqGSIb3DQEHATAcBgkqhkiG9w0BCQUxDxcNMTUwOTI0MTYxNzA0WjBPBgkq
hkiG9w0BCQQxQgRAWOjejYwBMw/vZWcsOi6JWRjSbKdWwfKUXdrWdGDVYaMHa9Ct/O/xXusp
FazlT7Np4BM0kwJ2NV9rzk0ZmiZ3bjBsBgkqhkiG9w0BCQ8xXzBdMAsGCWCGSAFlAwQBKjAL
BglghkgBZQMEAQIwCgYIKoZIhvcNAwcwDgYIKoZIhvcNAwICAgCAMA0GCCqGSIb3DQMCAgFA
MAcGBSsOAwIHMA0GCCqGSIb3DQMCAgEoMIGRBgkrBgEEAYI3EAQxgYMwgYAweTEQMA4GA1UE
ChMHUm9vdCBDQTEeMBwGA1UECxMVaHR0cDovL3d3dy5jYWNlcnQub3JnMSIwIAYDVQQDExlD
QSBDZXJ0IFNpZ25pbmcgQXV0aG9yaXR5MSEwHwYJKoZIhvcNAQkBFhJzdXBwb3J0QGNhY2Vy
dC5vcmcCAxEt+DCBkwYLKoZIhvcNAQkQAgsxgYOggYAweTEQMA4GA1UEChMHUm9vdCBDQTEe
MBwGA1UECxMVaHR0cDovL3d3dy5jYWNlcnQub3JnMSIwIAYDVQQDExlDQSBDZXJ0IFNpZ25p
bmcgQXV0aG9yaXR5MSEwHwYJKoZIhvcNAQkBFhJzdXBwb3J0QGNhY2VydC5vcmcCAxEt+DAN
BgkqhkiG9w0BAQEFAASCAgAG96DYi68cWznWcxTBsMU5sdu2A5ytGbHsZqE+N9ASJ1eqdBWz
qEzR4f1RRWt02UB+zPwfAhNAsTu/J8DdhJagF7g4l8BDLT5cWDtipkz8ArfjGbTai/PGdq/D
yR2l8OT1N3rMsLw3tH2+k1Ihcm840K9g5h2LNx1RUlm54v5qF+4vxBHxQqCJwbDh1llvm1ma
GYlCaX5+Fi18lEPCSQe0XVD095zQMHPve82TXiOR64Cnz1iW8mB7a3/SmP/Dj1COdVgGluQh
1wpT6HulAU5zqsDC4j8KdubEVxhtwXfijRwyuW0OPVsecHcRTRRLQOlvz8YTXyjkGyIf4BpX
eYA9MG90izMiEkf1rLYpHSl771x0HY2Ry3oJ76mV+SYbaGBdnpYdHiZrVQQFEoQiJ/9UoRD4
gIAwAwFfT4loRupCBkEBk0Hl+DzbfAk4qrr4tehUMFYEfFRyUZui9JRvcxkokjL6NTWfJTVx
+A/vWw9rY7f46+O8VBgWcO3cEXm/LA9vXP8+sFKFqGIEs/JuIQ62uAehR51tC2ZoC6z7FQe5
KsbYDaZLzw0IlSJNwPtw+ASvxELvS6YFy7KAXKQsuvdquXnxJce0PykV3azy4bLIF/yMOU6L
XfyaVnyLZksVuHCeywv6JXKfWx8LNlwvJOG0SYz1vlV6z/xQ5AEwry20rwAAAAAAAA==
--------------ms020307070306080802090908--
