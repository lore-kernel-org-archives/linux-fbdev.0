From: Zhou Zhu <zzhu3@marvell.com>
Date: Tue, 24 Sep 2013 07:55:13 +0000
Subject: Re: [PATCH] video: mmp: drop needless devm cleanup
Message-Id: <52414561.1010000@marvell.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1379951159-8294-1-git-send-email-u.kleine-koenig@pengutronix.de>
 <1379952790-13202-1-git-send-email-u.kleine-koenig@pengutronix.de>
 <20130923161944.GU12758@n2100.arm.linux.org.uk> <5241406B.8090106@ti.com>
In-Reply-To: <5241406B.8090106@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: linux-arm-kernel@lists.infradead.org

On 09/24/2013 03:34 PM, Tomi Valkeinen wrote:
> On 23/09/13 19:19, Russell King - ARM Linux wrote:
>> On Mon, Sep 23, 2013 at 06:13:10PM +0200, Uwe Kleine-K=F6nig wrote:
>>> The nice thing about devm_* is that the driver doesn't need to free the
>>> resources but the driver core takes care about that. This also
>>> simplifies the error path quite a bit and removes the wrong check for a
>>> clock pointer being NULL.
>>>
>>> Signed-off-by: Uwe Kleine-K=F6nig <u.kleine-koenig@pengutronix.de>
>>> ---
>>>   drivers/video/mmp/hw/mmp_ctrl.c | 17 ++---------------
>>>   1 file changed, 2 insertions(+), 15 deletions(-)
>>>
>>> diff --git a/drivers/video/mmp/hw/mmp_ctrl.c b/drivers/video/mmp/hw/mmp=
_ctrl.c
>>> index 75dca19..6ac7552 100644
>>> --- a/drivers/video/mmp/hw/mmp_ctrl.c
>>> +++ b/drivers/video/mmp/hw/mmp_ctrl.c
>>> @@ -514,7 +514,7 @@ static int mmphw_probe(struct platform_device *pdev)
>>>   	if (IS_ERR(ctrl->clk)) {
>>>   		dev_err(ctrl->dev, "unable to get clk %s\n", mi->clk_name);
>>>   		ret =3D -ENOENT;
>>> -		goto failed_get_clk;
>>> +		goto failed;
>>>   	}
>>>   	clk_prepare_enable(ctrl->clk);
>>>
>>> @@ -551,21 +551,8 @@ failed_path_init:
>>>   		path_deinit(path_plat);
>>>   	}
>>>
>>> -	if (ctrl->clk) {
>>> -		devm_clk_put(ctrl->dev, ctrl->clk);
>>> -		clk_disable_unprepare(ctrl->clk);
>>
>> And this patch also fixes the above: disabling/unpreparing _after_ putti=
ng
>> the thing - which was quite silly... :)
>
> Hmm, I wonder if that causes any issues... I.e. should this patch go for
> 3.12, or is 3.13 fine?
>
>   Tomi
>
It would cause oops if probe failed due to some reason - although it=20
would almost never happen so we missed it.
Thank you for finding it out.

--=20
Thanks, -Zhou
