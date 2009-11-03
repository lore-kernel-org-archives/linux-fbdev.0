From: Avi Kivity <avi@redhat.com>
Subject: Re: [Qemu-devel] Re: [PATCH] Add VirtIO Frame Buffer Support
Date: Tue, 03 Nov 2009 11:38:18 +0200
Message-ID: <4AEFFA0A.4040105@redhat.com>
References: <1257199759-2941-1-git-send-email-agraf@suse.de> <4AEFCBED.50804@redhat.com> <DB868FAB-60AA-4D3A-82AE-A3DAF1AF83B2@suse.de> <4AEFCCBA.9050408@redhat.com> <8BA1853F-11C9-44B1-9FDB-1DFDAED40E1B@suse.de> <4AEFCEDA.4030308@redhat.com> <87F51670-CB3F-431C-87B4-A8746F996C6F@suse.de> <20091103112543.GA24834@snarc.org>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <kvm-owner@vger.kernel.org>
In-Reply-To: <20091103112543.GA24834@snarc.org>
Sender: kvm-owner@vger.kernel.org
List-ID: <fbdev-devel.lists.sourceforge.net>
Content-Type: text/plain; charset="us-ascii"; format="flowed"
To: Vincent Hanquez <tab@snarc.org>
Cc: Alexander Graf <agraf@suse.de>, linux-fbdev-devel@lists.sourceforge.net, qemu-devel@nongnu.org, kvm@vger.kernel.org

On 11/03/2009 01:25 PM, Vincent Hanquez wrote:
> not sure if i'm missing the point here, but couldn't it be hypothetically
> extended to stuff 3d (or video&  more 2d accel ?) commands too ? I can't
> imagine the cirrus or stdvga driver be able to do that ever ;)
>    

cirrus has pretty good 2d acceleration.  3D is a mega-project though.

-- 
error compiling committee.c: too many arguments to function

