From: Paolo Bonzini <pbonzini@redhat.com>
Subject: Re: [Linux-fbdev-devel] Re: [PATCH] Add VirtIO Frame
	Buffer Support
Date: Tue, 03 Nov 2009 18:33:06 +0100
Message-ID: <hcpt12$8tb$1@ger.gmane.org>
References: <1257199759-2941-1-git-send-email-agraf@suse.de>
	<4AEFCBED.50804@redhat.com>
	<DB868FAB-60AA-4D3A-82AE-A3DAF1AF83B2@suse.de>
	<4AEFCCBA.9050408@redhat.com>
	<8BA1853F-11C9-44B1-9FDB-1DFDAED40E1B@suse.de>
	<4AEFCEDA.4030308@redhat.com>
	<87F51670-CB3F-431C-87B4-A8746F996C6F@suse.de>
	<20091103112543.GA24834@snarc.org>
	<4AEFFA0A.4040105@redhat.com> <20091103152911.GA8266@localhost>
	<4AF054B9.9060204@redhat.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <qemu-devel-bounces+gceq-qemu-devel=gmane.org@nongnu.org>
In-Reply-To: <4AF054B9.9060204@redhat.com>
List-Id: <fbdev-devel.lists.sourceforge.net>
List-Unsubscribe: <http://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.gnu.org/pipermail/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <http://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Sender: qemu-devel-bounces+gceq-qemu-devel=gmane.org@nongnu.org
Errors-To: qemu-devel-bounces+gceq-qemu-devel=gmane.org@nongnu.org
Content-Type: text/plain; charset="us-ascii"; format="flowed"
Cc: linux-fbdev-devel@lists.sourceforge.net, qemu-devel@nongnu.org, kvm@vger.kernel.org

On 11/03/2009 05:05 PM, Avi Kivity wrote:
> On 11/03/2009 05:29 PM, Ondrej Zajicek wrote:
>> On Tue, Nov 03, 2009 at 11:38:18AM +0200, Avi Kivity wrote:
>>> On 11/03/2009 01:25 PM, Vincent Hanquez wrote:
>>>> not sure if i'm missing the point here, but couldn't it be
>>>> hypothetically
>>>> extended to stuff 3d (or video& more 2d accel ?) commands too ? I can't
>>>> imagine the cirrus or stdvga driver be able to do that ever ;)
>>>>
>>> cirrus has pretty good 2d acceleration. 3D is a mega-project though.
>> Cirrus has no blending/compositing hardware support.
>> Paravirtualized graphics can easily support full XRender-style
>> 2D acceleration.
>
> What do that entail? 3/4 operand raster ops?

With alpha compositing.

Paolo
