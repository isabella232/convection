module Convection
  module Model
    # Unfortunately, there are a lot of resources to include in this array,
    # and rather than parsing out only the ones that we need right now
    # and potentially missing it in the future, just disable rubocop whining
    # about that particular error:
    # rubocop:disable ClassLength
    class Diff
      # Properties for which a change requires a replacement
      # (as opposed to an in-place update)
      # Create/update this list with tmp/process_html.sh
      REPLACE_PROPERTIES = [
        'AWS::ApiGateway::ApiKey.Name',
        'AWS::ApiGateway::Authorizer.RestApiId',
        'AWS::ApiGateway::Deployment.RestApiId',
        'AWS::ApiGateway::Model.ContentType',
        'AWS::ApiGateway::Model.Name',
        'AWS::ApiGateway::Model.RestApiId',
        'AWS::ApiGateway::Resource.ParentId',
        'AWS::ApiGateway::Resource.PathPart',
        'AWS::ApiGateway::Resource.RestApiId',
        'AWS::ApiGateway::Stage.RestApiId',
        'AWS::ApiGateway::Stage.StageName',
        'AWS::ApplicationAutoScaling::ScalableTarget.ResourceId',
        'AWS::ApplicationAutoScaling::ScalableTarget.ScalableDimension',
        'AWS::ApplicationAutoScaling::ScalableTarget.ServiceNamespace',
        'AWS::ApplicationAutoScaling::ScalingPolicy.PolicyName',
        'AWS::ApplicationAutoScaling::ScalingPolicy.ResourceId',
        'AWS::ApplicationAutoScaling::ScalingPolicy.ScalableDimension',
        'AWS::ApplicationAutoScaling::ScalingPolicy.ServiceNamespace',
        'AWS::ApplicationAutoScaling::ScalingPolicy.ScalingTargetId',
        'AWS::AutoScaling::AutoScalingGroup.InstanceId',
        'AWS::AutoScaling::AutoScalingGroup.LoadBalancerNames',
        'AWS::AutoScaling::LaunchConfiguration.AssociatePublicIpAddress',
        'AWS::AutoScaling::LaunchConfiguration.BlockDeviceMappings',
        'AWS::AutoScaling::LaunchConfiguration.ClassicLinkVPCId',
        'AWS::AutoScaling::LaunchConfiguration.ClassicLinkVPCSecurityGroups',
        'AWS::AutoScaling::LaunchConfiguration.EbsOptimized',
        'AWS::AutoScaling::LaunchConfiguration.IamInstanceProfile',
        'AWS::AutoScaling::LaunchConfiguration.ImageId',
        'AWS::AutoScaling::LaunchConfiguration.InstanceId',
        'AWS::AutoScaling::LaunchConfiguration.InstanceMonitoring',
        'AWS::AutoScaling::LaunchConfiguration.InstanceType',
        'AWS::AutoScaling::LaunchConfiguration.KernelId',
        'AWS::AutoScaling::LaunchConfiguration.KeyName',
        'AWS::AutoScaling::LaunchConfiguration.PlacementTenancy',
        'AWS::AutoScaling::LaunchConfiguration.RamDiskId',
        'AWS::AutoScaling::LaunchConfiguration.SecurityGroups',
        'AWS::AutoScaling::LaunchConfiguration.SpotPrice',
        'AWS::AutoScaling::LaunchConfiguration.UserData',
        'AWS::AutoScaling::LifecycleHook.AutoScalingGroupName',
        'AWS::AutoScaling::ScheduledAction.AutoScalingGroupName',
        'AWS::CertificateManager::Certificate.DomainName',
        'AWS::CertificateManager::Certificate.DomainValidationOptions',
        'AWS::CertificateManager::Certificate.SubjectAlternativeNames',
        'AWS::CloudWatch::Alarm.AlarmName',
        'AWS::CodeBuild::Project.Name',
        'AWS::CodeDeploy::DeploymentConfig.DeploymentConfigName',
        'AWS::CodeDeploy::DeploymentConfig.MinimumHealthyHosts',
        'AWS::CodeDeploy::DeploymentGroup.ApplicationName',
        'AWS::CodeDeploy::DeploymentGroup.DeploymentGroupName',
        'AWS::CodePipeline::CustomActionType.Category',
        'AWS::CodePipeline::CustomActionType.ConfigurationProperties',
        'AWS::CodePipeline::CustomActionType.InputArtifactDetails',
        'AWS::CodePipeline::CustomActionType.OutputArtifactDetails',
        'AWS::CodePipeline::CustomActionType.Provider',
        'AWS::CodePipeline::CustomActionType.Settings',
        'AWS::CodePipeline::CustomActionType.Version',
        'AWS::Config::ConfigRule.ConfigRuleName',
        'AWS::DataPipeline::Pipeline.Description',
        'AWS::DataPipeline::Pipeline.Name',
        'AWS::DirectoryService::MicrosoftAD.CreateAlias',
        'AWS::DirectoryService::MicrosoftAD.Name',
        'AWS::DirectoryService::MicrosoftAD.Password',
        'AWS::DirectoryService::MicrosoftAD.ShortName',
        'AWS::DirectoryService::MicrosoftAD.VpcSettings',
        'AWS::DirectoryService::SimpleAD.CreateAlias',
        'AWS::DirectoryService::SimpleAD.Description',
        'AWS::DirectoryService::SimpleAD.Name',
        'AWS::DirectoryService::SimpleAD.Password',
        'AWS::DirectoryService::SimpleAD.ShortName',
        'AWS::DirectoryService::SimpleAD.Size',
        'AWS::DirectoryService::SimpleAD.VpcSettings',
        'AWS::DynamoDB::Table.AttributeDefinitions',
        'AWS::DynamoDB::Table.KeySchema',
        'AWS::DynamoDB::Table.LocalSecondaryIndexes',
        'AWS::DynamoDB::Table.TableName',
        'AWS::EC2::CustomerGateway.BgpAsn',
        'AWS::EC2::CustomerGateway.IpAddress',
        'AWS::EC2::CustomerGateway.Type',
        'AWS::EC2::DHCPOptions.DomainName',
        'AWS::EC2::DHCPOptions.DomainNameServers',
        'AWS::EC2::DHCPOptions.NetbiosNameServers',
        'AWS::EC2::DHCPOptions.NetbiosNodeType',
        'AWS::EC2::DHCPOptions.NtpServers',
        'AWS::EC2::EIP.Domain',
        'AWS::EC2::EIPAssociation.AllocationId',
        'AWS::EC2::EIPAssociation.EIP',
        'AWS::EC2::EIPAssociation.InstanceId',
        'AWS::EC2::EIPAssociation.NetworkInterfaceId',
        'AWS::EC2::FlowLog.DeliverLogsPermissionArn',
        'AWS::EC2::FlowLog.LogGroupName',
        'AWS::EC2::FlowLog.ResourceId',
        'AWS::EC2::FlowLog.ResourceType',
        'AWS::EC2::FlowLog.TrafficType',
        'AWS::EC2::Host.AvailabilityZone',
        'AWS::EC2::Host.InstanceType',
        'AWS::EC2::Instance.AvailabilityZone',
        'AWS::EC2::Instance.BlockDeviceMappings',
        'AWS::EC2::Instance.EbsOptimized',
        'AWS::EC2::Instance.IamInstanceProfile',
        'AWS::EC2::Instance.ImageId',
        'AWS::EC2::Instance.InstanceType',
        'AWS::EC2::Instance.KernelId',
        'AWS::EC2::Instance.KeyName',
        'AWS::EC2::Instance.NetworkInterfaces',
        'AWS::EC2::Instance.PlacementGroupName',
        'AWS::EC2::Instance.PrivateIpAddress',
        'AWS::EC2::Instance.RamdiskId',
        'AWS::EC2::Instance.SecurityGroupIds',
        'AWS::EC2::Instance.SecurityGroups',
        'AWS::EC2::Instance.SubnetId',
        'AWS::EC2::Instance.Tenancy',
        'AWS::EC2::Instance.UserData',
        'AWS::EC2::Instance.AdditionalInfo',
        'AWS::EC2::NatGateway.AllocationId',
        'AWS::EC2::NatGateway.SubnetId',
        'AWS::EC2::NetworkAcl.VpcId',
        'AWS::EC2::NetworkAclEntry.Egress',
        'AWS::EC2::NetworkAclEntry.NetworkAclId',
        'AWS::EC2::NetworkAclEntry.RuleNumber',
        'AWS::EC2::NetworkInterface.PrivateIpAddress',
        'AWS::EC2::NetworkInterface.PrivateIpAddresses',
        'AWS::EC2::NetworkInterface.SubnetId',
        'AWS::EC2::PlacementGroup.Strategy',
        'AWS::EC2::Route.DestinationCidrBlock',
        'AWS::EC2::Route.RouteTableId',
        'AWS::EC2::RouteTable.VpcId',
        'AWS::EC2::SecurityGroup.GroupDescription',
        'AWS::EC2::SecurityGroup.VpcId',
        'AWS::EC2::SecurityGroupEgress.CidrIp',
        'AWS::EC2::SecurityGroupEgress.DestinationPrefixListId',
        'AWS::EC2::SecurityGroupEgress.DestinationSecurityGroupId',
        'AWS::EC2::SecurityGroupEgress.FromPort',
        'AWS::EC2::SecurityGroupEgress.GroupId',
        'AWS::EC2::SecurityGroupEgress.IpProtocol',
        'AWS::EC2::SecurityGroupEgress.ToPort',
        'AWS::EC2::SecurityGroupIngress.CidrIp',
        'AWS::EC2::SecurityGroupIngress.FromPort',
        'AWS::EC2::SecurityGroupIngress.GroupId',
        'AWS::EC2::SecurityGroupIngress.GroupName',
        'AWS::EC2::SecurityGroupIngress.IpProtocol',
        'AWS::EC2::SecurityGroupIngress.SourceSecurityGroupId',
        'AWS::EC2::SecurityGroupIngress.SourceSecurityGroupName',
        'AWS::EC2::SecurityGroupIngress.SourceSecurityGroupOwnerId',
        'AWS::EC2::SecurityGroupIngress.ToPort',
        'AWS::EC2::SpotFleet.SpotFleetRequestConfigData',
        'AWS::EC2::Subnet.AvailabilityZone',
        'AWS::EC2::Subnet.CidrBlock',
        'AWS::EC2::Subnet.VpcId',
        'AWS::EC2::SubnetCidrBlock.Ipv6CidrBlock',
        'AWS::EC2::SubnetCidrBlock.SubnetId',
        'AWS::EC2::SubnetNetworkAclAssociation.SubnetId',
        'AWS::EC2::SubnetNetworkAclAssociation.NetworkAclId',
        'AWS::EC2::SubnetRouteTableAssociation.SubnetId',
        'AWS::EC2::VPC.CidrBlock',
        'AWS::EC2::VPC.InstanceTenancy',
        'AWS::EC2::VPCCidrBlock.AmazonProvidedIpv6CidrBlock',
        'AWS::EC2::VPCCidrBlock.VpcId',
        'AWS::EC2::VPCDHCPOptionsAssociation.VpcId',
        'AWS::EC2::VPCEndpoint.ServiceName',
        'AWS::EC2::VPCEndpoint.VpcId',
        'AWS::EC2::VPCPeeringConnection.PeerVpcId',
        'AWS::EC2::VPCPeeringConnection.VpcId',
        'AWS::EC2::VPNConnection.Type',
        'AWS::EC2::VPNConnection.CustomerGatewayId',
        'AWS::EC2::VPNConnection.StaticRoutesOnly',
        'AWS::EC2::VPNConnection.VpnGatewayId',
        'AWS::EC2::VPNConnectionRoute.DestinationCidrBlock',
        'AWS::EC2::VPNConnectionRoute.VpnConnectionId',
        'AWS::EC2::VPNGateway.Type',
        'AWS::ECR::Repository.RepositoryName',
        'AWS::ECS::Cluster.ClusterName',
        'AWS::ECS::Service.Cluster',
        'AWS::ECS::Service.LoadBalancers',
        'AWS::ECS::Service.Role',
        'AWS::ECS::TaskDefinition.ContainerDefinitions',
        'AWS::ECS::TaskDefinition.Family',
        'AWS::ECS::TaskDefinition.TaskRoleArn',
        'AWS::ECS::TaskDefinition.Volumes',
        'AWS::EFS::FileSystem.PerformanceMode',
        'AWS::EFS::MountTarget.FileSystemId',
        'AWS::EFS::MountTarget.IpAddress',
        'AWS::EFS::MountTarget.SubnetId',
        'AWS::ElastiCache::CacheCluster.CacheSubnetGroupName',
        'AWS::ElastiCache::CacheCluster.ClusterName',
        'AWS::ElastiCache::CacheCluster.Engine',
        'AWS::ElastiCache::CacheCluster.Port',
        'AWS::ElastiCache::CacheCluster.PreferredAvailabilityZone',
        'AWS::ElastiCache::CacheCluster.SnapshotArns',
        'AWS::ElastiCache::CacheCluster.SnapshotName',
        'AWS::ElastiCache::ReplicationGroup.CacheSubnetGroupName',
        'AWS::ElastiCache::ReplicationGroup.NodeGroupConfiguration',
        'AWS::ElastiCache::ReplicationGroup.NumNodeGroups',
        'AWS::ElastiCache::ReplicationGroup.Port',
        'AWS::ElastiCache::ReplicationGroup.PreferredCacheClusterAZs',
        'AWS::ElastiCache::ReplicationGroup.ReplicasPerNodeGroup',
        'AWS::ElastiCache::ReplicationGroup.ReplicationGroupId',
        'AWS::ElastiCache::ReplicationGroup.SnapshotArns',
        'AWS::ElastiCache::ReplicationGroup.SnapshotName',
        'AWS::ElastiCache::SubnetGroup.CacheSubnetGroupName',
        'AWS::ElasticBeanstalk::Application.ApplicationName',
        'AWS::ElasticBeanstalk::ApplicationVersion.ApplicationName',
        'AWS::ElasticBeanstalk::ApplicationVersion.SourceBundle',
        'AWS::ElasticBeanstalk::ConfigurationTemplate.ApplicationName',
        'AWS::ElasticBeanstalk::ConfigurationTemplate.EnvironmentId',
        'AWS::ElasticBeanstalk::ConfigurationTemplate.SolutionStackName',
        'AWS::ElasticBeanstalk::ConfigurationTemplate.SourceConfiguration',
        'AWS::ElasticBeanstalk::Environment.ApplicationName',
        'AWS::ElasticBeanstalk::Environment.CNAMEPrefix',
        'AWS::ElasticBeanstalk::Environment.EnvironmentName',
        'AWS::ElasticBeanstalk::Environment.SolutionStackName',
        'AWS::ElasticLoadBalancing::LoadBalancer.AvailabilityZones',
        'AWS::ElasticLoadBalancing::LoadBalancer.HealthCheck',
        'AWS::ElasticLoadBalancing::LoadBalancer.LoadBalancerName',
        'AWS::ElasticLoadBalancing::LoadBalancer.Scheme',
        'AWS::ElasticLoadBalancing::LoadBalancer.Subnets',
        'AWS::ElasticLoadBalancingV2::Listener.LoadBalancerArn',
        'AWS::ElasticLoadBalancingV2::ListenerRule.ListenerArn',
        'AWS::ElasticLoadBalancingV2::LoadBalancer.Name',
        'AWS::ElasticLoadBalancingV2::LoadBalancer.Scheme',
        'AWS::ElasticLoadBalancingV2::TargetGroup.Name',
        'AWS::ElasticLoadBalancingV2::TargetGroup.Port',
        'AWS::ElasticLoadBalancingV2::TargetGroup.Protocol',
        'AWS::ElasticLoadBalancingV2::TargetGroup.VpcId',
        'AWS::Elasticsearch::Domain.AdvancedOptions',
        'AWS::Elasticsearch::Domain.DomainName',
        'AWS::Elasticsearch::Domain.ElasticsearchVersion',
        'AWS::EMR::Cluster.AdditionalInfo',
        'AWS::EMR::Cluster.Applications',
        'AWS::EMR::Cluster.BootstrapActions',
        'AWS::EMR::Cluster.Configurations',
        'AWS::EMR::Cluster.Instances',
        'AWS::EMR::Cluster.JobFlowRole',
        'AWS::EMR::Cluster.LogUri',
        'AWS::EMR::Cluster.Name',
        'AWS::EMR::Cluster.ReleaseLabel',
        'AWS::EMR::Cluster.ServiceRole',
        'AWS::EMR::InstanceGroupConfig.BidPrice',
        'AWS::EMR::InstanceGroupConfig.Configurations',
        'AWS::EMR::InstanceGroupConfig.EbsConfiguration',
        'AWS::EMR::InstanceGroupConfig.InstanceRole',
        'AWS::EMR::InstanceGroupConfig.InstanceType',
        'AWS::EMR::InstanceGroupConfig.JobFlowId',
        'AWS::EMR::InstanceGroupConfig.Market',
        'AWS::EMR::InstanceGroupConfig.Name',
        'AWS::EMR::Step.ActionOnFailure',
        'AWS::EMR::Step.HadoopJarStep',
        'AWS::EMR::Step.JobFlowId',
        'AWS::EMR::Step.Name',
        'AWS::Events::Rule.Name',
        'AWS::GameLift::Build.StorageLocation',
        'AWS::GameLift::Fleet.BuildId',
        'AWS::GameLift::Fleet.EC2InstanceType',
        'AWS::GameLift::Fleet.LogPaths',
        'AWS::GameLift::Fleet.ServerLaunchParameters',
        'AWS::GameLift::Fleet.ServerLaunchPath',
        'AWS::IAM::AccessKey.Serial',
        'AWS::IAM::AccessKey.UserName',
        'AWS::IAM::Group.GroupName',
        'AWS::IAM::InstanceProfile.Path',
        'AWS::IAM::ManagedPolicy.Description',
        'AWS::IAM::ManagedPolicy.Path',
        'AWS::IAM::Role.Path',
        'AWS::IAM::Role.RoleName',
        'AWS::IAM::User.UserName',
        'AWS::IoT::Certificate.CertificateSigningRequest',
        'AWS::IoT::Policy.PolicyDocument',
        'AWS::IoT::Policy.PolicyName',
        'AWS::IoT::PolicyPrincipalAttachment.PolicyName',
        'AWS::IoT::PolicyPrincipalAttachment.Principal',
        'AWS::IoT::Thing.ThingName',
        'AWS::IoT::ThingPrincipalAttachment.Principal',
        'AWS::IoT::ThingPrincipalAttachment.ThingName',
        'AWS::IoT::TopicRule.RuleName',
        'AWS::Kinesis::Stream.Name',
        'AWS::Kinesis::Stream.ShardCount',
        'AWS::KinesisFirehose::DeliveryStream.DeliveryStreamName',
        'AWS::KMS::Alias.AliasName',
        'AWS::Lambda::EventSourceMapping.EventSourceArn',
        'AWS::Lambda::EventSourceMapping.StartingPosition',
        'AWS::Lambda::Alias.FunctionName',
        'AWS::Lambda::Alias.Name',
        'AWS::Lambda::Function.FunctionName',
        'AWS::Lambda::Function.Runtime',
        'AWS::Lambda::Permission.Action',
        'AWS::Lambda::Permission.FunctionName',
        'AWS::Lambda::Permission.Principal',
        'AWS::Lambda::Permission.SourceAccount',
        'AWS::Lambda::Permission.SourceArn',
        'AWS::Lambda::Version.FunctionName',
        'AWS::Logs::Destination.DestinationName',
        'AWS::Logs::LogGroup.LogGroupName',
        'AWS::Logs::LogStream.LogGroupName',
        'AWS::Logs::LogStream.LogStreamName',
        'AWS::Logs::MetricFilter.LogGroupName',
        'AWS::Logs::SubscriptionFilter.DestinationArn',
        'AWS::Logs::SubscriptionFilter.FilterPattern',
        'AWS::Logs::SubscriptionFilter.LogGroupName',
        'AWS::Logs::SubscriptionFilter.RoleArn',
        'AWS::OpsWorks::App.Shortname',
        'AWS::OpsWorks::App.StackId',
        'AWS::OpsWorks::Instance.AutoScalingType',
        'AWS::OpsWorks::Instance.AvailabilityZone',
        'AWS::OpsWorks::Instance.EbsOptimized',
        'AWS::OpsWorks::Instance.Os',
        'AWS::OpsWorks::Instance.RootDeviceType',
        'AWS::OpsWorks::Instance.StackId',
        'AWS::OpsWorks::Instance.SubnetId',
        'AWS::OpsWorks::Instance.TimeBasedAutoScaling',
        'AWS::OpsWorks::Layer.StackId',
        'AWS::OpsWorks::Layer.Type',
        'AWS::OpsWorks::Layer.VolumeConfigurations',
        'AWS::OpsWorks::Stack.ServiceRoleArn',
        'AWS::OpsWorks::Stack.VpcId',
        'AWS::OpsWorks::UserProfile.IamUserArn',
        'AWS::OpsWorks::Volume.Ec2VolumeId',
        'AWS::OpsWorks::Volume.StackId',
        'AWS::RDS::DBCluster.AvailabilityZones',
        'AWS::RDS::DBCluster.DatabaseName',
        'AWS::RDS::DBCluster.DBSubnetGroupName',
        'AWS::RDS::DBCluster.Engine',
        'AWS::RDS::DBCluster.EngineVersion',
        'AWS::RDS::DBCluster.KmsKeyId',
        'AWS::RDS::DBCluster.MasterUsername',
        'AWS::RDS::DBCluster.SnapshotIdentifier',
        'AWS::RDS::DBCluster.StorageEncrypted',
        'AWS::RDS::DBClusterParameterGroup.Description',
        'AWS::RDS::DBClusterParameterGroup.Family',
        'AWS::RDS::DBInstance.AvailabilityZone',
        'AWS::RDS::DBInstance.CharacterSetName',
        'AWS::RDS::DBInstance.DBClusterIdentifier',
        'AWS::RDS::DBInstance.DBInstanceIdentifier',
        'AWS::RDS::DBInstance.DBName',
        'AWS::RDS::DBInstance.DBSnapshotIdentifier',
        'AWS::RDS::DBInstance.DBSubnetGroupName',
        'AWS::RDS::DBInstance.Engine',
        'AWS::RDS::DBInstance.KmsKeyId',
        'AWS::RDS::DBInstance.LicenseModel',
        'AWS::RDS::DBInstance.MasterUsername',
        'AWS::RDS::DBInstance.Port',
        'AWS::RDS::DBInstance.PubliclyAccessible',
        'AWS::RDS::DBInstance.SourceDBInstanceIdentifier',
        'AWS::RDS::DBInstance.StorageEncrypted',
        'AWS::RDS::DBInstance.VPCSecurityGroups',
        'AWS::RDS::DBSecurityGroup.EC2VpcId',
        'AWS::RDS::DBSecurityGroup.GroupDescription',
        'AWS::RDS::EventSubscription.SnsTopicArn',
        'AWS::RDS::EventSubscription.SourceType',
        'AWS::RDS::OptionGroup.EngineName',
        'AWS::RDS::OptionGroup.MajorEngineVersion',
        'AWS::RDS::OptionGroup.OptionGroupDescription',
        'AWS::RDS::OptionGroup.OptionConfigurations',
        'AWS::Redshift::Cluster.AvailabilityZone',
        'AWS::Redshift::Cluster.ClusterSubnetGroupName',
        'AWS::Redshift::Cluster.DBName',
        'AWS::Redshift::Cluster.ElasticIp',
        'AWS::Redshift::Cluster.Encrypted',
        'AWS::Redshift::Cluster.KmsKeyId',
        'AWS::Redshift::Cluster.MasterUsername',
        'AWS::Redshift::Cluster.OwnerAccount',
        'AWS::Redshift::Cluster.Port',
        'AWS::Redshift::Cluster.PubliclyAccessible',
        'AWS::Redshift::Cluster.SnapshotClusterIdentifier',
        'AWS::Redshift::Cluster.SnapshotIdentifier',
        'AWS::Redshift::ClusterParameterGroup.Description',
        'AWS::Redshift::ClusterParameterGroup.ParameterGroupFamily',
        'AWS::Redshift::ClusterSecurityGroup.Description',
        'AWS::Redshift::ClusterSecurityGroupIngress.ClusterSecurityGroupName',
        'AWS::Redshift::ClusterSecurityGroupIngress.CIDRIP',
        'AWS::Redshift::ClusterSecurityGroupIngress.EC2SecurityGroupName',
        'AWS::Redshift::ClusterSecurityGroupIngress.EC2SecurityGroupOwnerId',
        'AWS::Route53::HostedZone.Name',
        'AWS::Route53::RecordSet.HostedZoneId',
        'AWS::Route53::RecordSet.HostedZoneName',
        'AWS::Route53::RecordSet.Name',
        'AWS::Route53::RecordSetGroup.HostedZoneId',
        'AWS::Route53::RecordSetGroup.HostedZoneName',
        'AWS::S3::Bucket.BucketName',
        'AWS::SNS::Subscription.Endpoint',
        'AWS::SNS::Subscription.Protocol',
        'AWS::SNS::Subscription.TopicArn',
        'AWS::SNS::Topic.TopicName',
        'AWS::SQS::Queue.QueueName',
        'AWS::SSM::Association.InstanceId',
        'AWS::SSM::Association.Name',
        'AWS::SSM::Association.Targets',
        'AWS::SSM::Document.Content',
        'AWS::StepFunctions::Activity.Name',
        'AWS::StepFunctions::StateMachine.DefinitionString',
        'AWS::StepFunctions::StateMachine.RoleArn',
        'AWS::WAF::ByteMatchSet.Name',
        'AWS::WAF::IPSet.Name',
        'AWS::WAF::Rule.MetricName',
        'AWS::WAF::Rule.Name',
        'AWS::WAF::SizeConstraintSet.Name',
        'AWS::WAF::SqlInjectionMatchSet.Name',
        'AWS::WAF::WebACL.MetricName',
        'AWS::WAF::WebACL.Name',
        'AWS::WAF::XssMatchSet.Name',
        'AWS::WorkSpaces::Workspace.DirectoryId',
        'AWS::WorkSpaces::Workspace.UserName'
      ].freeze
    end
  end
end
